Return-Path: <linux-rdma+bounces-10853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D5AC6E6B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CF83BB23D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56928DF06;
	Wed, 28 May 2025 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pteV2oA1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFD28DEFE
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451153; cv=fail; b=spMaJvZtWtdxEh7iu1uiXUq6uoVgCn3frOY5hHQwS0zRpoLGr7aT9b5nFj4CPU0bzgw7R/mFOboQPk87HhLn2aZ9EcgY+y3C9Y8h+0IgiKAagD3xb7qWVl9dDlA6pO0xla0/U6G8GYHNH2/ckL5MXEUCZtHvmkJkox4LWOiMSww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451153; c=relaxed/simple;
	bh=gc7qrd+fnSutR9f7sDxq5pdIRI7O0W09+6yj/nybinc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XwTfsOIrejNCAlQPFFV4YooETc8ahFqEp87XaVfl38bJGuhe1GTs7gfK2mLH0gWyTMZdD5BzCKt/72iJmV2rnulPT7euD6Q9QzqqY8WtFLsADVhIQ+nQtAaO8Jow9byLQYMl8lxjSWTOpWxee0NL8H91z4Kbztu1Dbm5MMgyElc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pteV2oA1; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9Qxd022253
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 16:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=stL5Qf
	RV4UpXxZFsDDw0nzASkhqxtJ6EAeLPwMI7uv4=; b=pteV2oA1Ysycc63eRxnBxp
	4b0u7uuulc9Jokz1UUEgcEZ4Hd1yZOgHKLpq+oq0gAvYBu9oN5GKyeupmsygMSnH
	/dM5WfpPv3dt9Y+bl88g4NzB/vEDXWfW+4gXwrraBsH7bvEXeDAKoasQmD8pHVYK
	kk5S6Go9n/wKk8u0Nk0DiKdUQ+tw6BnKE3hKLg08oMuGcG3woMV7/d3RCRROjaab
	jRhFRLK0InmCmUVgoaof6Az3XamEz3JREaHt+vCjj+63LW7eDi2kKzTLHvVZJJFR
	nKNhwfCDItWNSpM9YZxj7dDA1/Y4wHeJ3b/G38uw1G1Z/W3RyVTEc8TljRYTt29g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40k8uwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 16:52:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54SGqReT023237;
	Wed, 28 May 2025 16:52:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40k8uwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 16:52:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW0vKXfB8Z2LjUiSo1Or26lXpNDt0qZoiWlDh4DuLQzEuE0f361LAObr2ZhDbUxV3Qzm+HU/gIgjL0CUC1SvK6y/zEcZ2rHXMxOMQ24XssIsP+lsvfPSa8RyvVMnmp3JISn9nCa1+hOMbv37Cpl0NJIPGfk3DHofZKAljXsvkQXA59Oy2DPRqi94kXBN/vvz2BLu32d3S7RByflUYxoTZJGoduD6Eqk9RZyyI2oNRSzP19foJd/Mj2HrQXAVLI+b0StpRDn4yhg5kL9hYh/QXhjd4jXNjofaj6CTYgN4UqQcsfF66NuPvaepqt/vsWUe5y97hGCdD8xDYB2Kcj/cTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz8uhSquywnTUvhGlaoXsFfQzLHuYeJUo934QIa50+g=;
 b=l8ojdD+5/0eqI9tTt/XYvwPEeTDJ+JRQJGWJuewWuqjPmr1eSufYyePenPfOS+81dYh2G6ly2m9berqZhf7sUnta/052HkpFXN1ONq/ARhC6smtKlTpnOLfr4lx0HZPmF4tTMNLxXKIll065GQF4eczeX8EVrLVwO4voFP0HZo5HK12rG/w88uWIWJy29E3p+w12LZhpijwhFLET9LQVudB7alYjZ/GPaQhG7T+NtIvUEoVy8Y5sHKktvwd4C4/4hTRYl1ACACrdaJu47hucNbwqrcUI2b2KmJf3Hq8F/IYjvqPe+pan1SplT0x3HC0kyZ1C2vbUi+VcuYXLgI+2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by BY3PR15MB4884.namprd15.prod.outlook.com (2603:10b6:a03:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 16:52:24 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 16:52:24 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot
	<oliver.sang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky
	<leon@kernel.org>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com"
	<lkp@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox
	<willy@infradead.org>, Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [linux-next:master] [mm, slab] 6431f06eec:
 WARNING:at_include/linux/mm.h:#skb_append_pagefrags
Thread-Index: AQHbz7Vk8W+azlWvVUWhHurDT06HJLPoJvwg
Date: Wed, 28 May 2025 16:52:24 +0000
Message-ID:
 <BN8PR15MB251311AA63AE08F9E868B0F89967A@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <202505221248.595a9117-lkp@intel.com>
 <610d1a69-e237-43ec-b554-d52b5308ace1@suse.cz>
In-Reply-To: <610d1a69-e237-43ec-b554-d52b5308ace1@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|BY3PR15MB4884:EE_
x-ms-office365-filtering-correlation-id: 00d20a99-48b5-40ff-e755-08dd9e080562
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVdnc2J4TWxDZ3pvMGpERXJuaEN3V1BmMVNYRHd4SXN0dG5HTDFkODgwclUy?=
 =?utf-8?B?dHprTHRvbEc2SXVlS0RHUC9MWUxaY25OWTZ1UUdndHliTXFCZWYzcTVWUS9S?=
 =?utf-8?B?My9NUjd4akE3MnpRYnNHV2Nac3NWeC9TYzBlN2hYQzNYZmdvR3V2TG0rVUtu?=
 =?utf-8?B?ck5kZmRkb0FFdkVYU0ZiMEo3VjVobkFhcnRBNE9XUStNTmFnQlYvdVl4Z0hw?=
 =?utf-8?B?aGNYY3JaeWY2dU9CdU1zbEJXRlYxLzJveWFFamNQSytjVnNmejFwbGtkRjdi?=
 =?utf-8?B?ZnVOZkhKT0FsbTNoL2t6aldHd2hWSkRoaUtCSnFFUGtTS1R6UVZoZEgwMjBI?=
 =?utf-8?B?R0lsZVBheHVZQlprUGdEZWNaUGJMTmxObHpXYnVHNmtoNUFFdmJPTWE3UjZV?=
 =?utf-8?B?aXVJaTlJclZsVE1vN0VUelY2MDlWT2tUbW9QMTVIekp2R3E3cml3MS9NMHAw?=
 =?utf-8?B?dzh2cXhGK1JGZmxMSFZSVWxORHlGOTFWMVhXTURmSEt6UHQxbFE2N2d3WnYy?=
 =?utf-8?B?cmZ4VEFDSDB1TWxXdkNhYkZ4TnZpSDNzZjlGbmFPdEFUMmtic1BxcW1WMDZv?=
 =?utf-8?B?RjIrUTVHUm4wMnVEYyt0T21pbUR3bmI2ODRTRXYzZHl4UlFtSEd1a1kyRmlQ?=
 =?utf-8?B?WjJWWGtmT1VHZmQxbjhHclV0eUp0TExYd25WQkdUd2Z1YjJCTGN0Y3crRlVw?=
 =?utf-8?B?QTQ2WnVxSFp2UEZDYS9odWZub1I1M3VTT0xUUVdaUlJyTHdCQkExYStxZEJq?=
 =?utf-8?B?VEpSbzVaTmFoVGUrNFYrbkQ0dWh6VEFZZjI5aWpQVEJ3N1dTMGJzTmx6dWkx?=
 =?utf-8?B?VnNTOVJkZUpUVndpK3l6ZG1xbWtOd0NyaVl4NjlaL2VvVFNtczlqT1ZrWkE5?=
 =?utf-8?B?dEordXhCbXR6MjR3Y2lGM3phZTBIT3p1T2JwbVZzTjEwNHI1NXJ6NFZ3clZ2?=
 =?utf-8?B?aWExb1ExYmZOY0lNMitQVFFhMEhXQnhXMnE1U0NneWhOYU1UajluSVovK2JF?=
 =?utf-8?B?TEFRcHZZVTF1aW9NeHhjOThGcGd5L3RmYUJWQWEyN3FaM0lmZmltbkQ1NFRQ?=
 =?utf-8?B?SFRHR0NaTjVuNkNjd0FoRFVKOEd3Qzl6MGpReVVrcWpQWVV6Y0ZuY0tPWCtU?=
 =?utf-8?B?TWZIRjJJVloyYkxxRnNrWFc4TEpHL2ZoM1BKakVQSmZRTXFiTWxvd0NmOXhP?=
 =?utf-8?B?WUxoOXZOY084RUhLOExuRCtBRDFHRmdkU2pCeEN2eHdpZWxtZE1xemRhTUFW?=
 =?utf-8?B?MGRPYVZac2xoeVdLSURmU2hxc1JDUEQ1ZUVRU1BOdFVXU0J2LzhqOUNPTHhw?=
 =?utf-8?B?UitCYmNVMUM0SWp0OVhrWTRML1RhaXd5RkJsSjhjSE5rQlMwOFh4cFFuQXBu?=
 =?utf-8?B?a29mNGtuQm5ZWFkrRXhBRHR2WHA1cHMxWWpSMjR5UFcrUkx4L3RuaXVCK05B?=
 =?utf-8?B?czE1S1hpVGpMZ3Q1eDBrN3h1cHRyTXFRZUROVTc0NmtmSTZvckJuYktjQmRT?=
 =?utf-8?B?SnBET2dSMnMzUVFUd2NMZmg4YTRURnZOaGlzVk14M29KbjNpQzV3dE5TMEY3?=
 =?utf-8?B?ZWdqeGRyY1RwMUhoTkJPSkw2bUZyc2haQWdhMk54SzkvVjFxZ2N0RlM2QUxK?=
 =?utf-8?B?S1hLR2JHdnI1bVdNWktWTDFoQ0wveVFHYkhJRHB6VmJhSHhZdloxVzA2WVNm?=
 =?utf-8?B?YVZGbFp6Y3JGazhjblBpdC9GZGxJM2I0SGVqSndQZ1RtY1lMaS9zdWUxQ1ZW?=
 =?utf-8?B?L01mZDFwT3lSZ0J0TDk2RGpZVjRSekxiVk1KcHZEc05SWEhZU0hnWDc3dXRq?=
 =?utf-8?B?Q3RNWW1BN0FDNzhYaC9LV3pseGUyTUZBSUpGd1Q4cElaT0VNUVJjNlhXbGhw?=
 =?utf-8?B?dkd0YUFrbXgyUmdUcTROdlA1SlNweW1GK0YrZFpuL0lSQ0E5T1h3eTBmZFVh?=
 =?utf-8?Q?W8eK1C/M06k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVpBbkFZbG0vcG5uUUlCL1dFYXJZZEMxU21sVU5xTTNkUTVMTHViTWJENFNO?=
 =?utf-8?B?MkFvekQxVzV6Y3ZYcXV3YXY5RHJXSnMyUEhSa3pMMk84TFhpd0Z3S0ZET3JJ?=
 =?utf-8?B?cDc4VTR1WGUxR2FGTitFWXVIaE1LN3BzekltOGlMQlpUYVVkdjJmbzlzZ20x?=
 =?utf-8?B?Tm03cWIyUVQ4SGRoMkhVVTJLcHd5RlIzbktSZjNrRkNSQ3NnV21OMGV4K01O?=
 =?utf-8?B?V2JzMVloSHhCeGNhQVhwQzUrUCtBUi9yTjdoaWhEQmpNVjBwUk5qU3l4L3FT?=
 =?utf-8?B?NWhpSzZiTEJLWjhpWmlISTVJelBUMDlvODNpc0NGYzJBSXBoamRobWxHdkF5?=
 =?utf-8?B?QUNITlVqTlBDNmE0VVJvbWZxckdBejB2K29mWVZYTjdaL3FiVWhWTC9xVE9I?=
 =?utf-8?B?cTVhekdDdThhQXo4cVYzaWtJQ2Y3ZFZidS83NmxScGs0TG55WmJwNWJKc0Nx?=
 =?utf-8?B?VGIyYjdCcUNBbmI5Z3BTM1RibnpDckN2RkVSODFYOGZxQVlMUGxEY1lnMnFL?=
 =?utf-8?B?ekdOUVRLY2tYc1hSSmhRUjl1MVpRWEYvVE83VUlVZDREVjJrbmVXQnZxL3Rn?=
 =?utf-8?B?a2JjbzFLRnB4Q3dsWFhBYjRrY2tDbkUwS2ZQQVNZMm42Uk5kcTFCSmtrditI?=
 =?utf-8?B?Z0k4VFMzUVZ5ZENvNjBzMmd6QzgxT2d3RFJkUWhYdERzTDN1dXBCOVJhNmo3?=
 =?utf-8?B?MEphYm9xc2pXa05DWXlVd0F4cWcrNGp5TnJ4N1JsOWRMOG9JWFFsMXZMQWxk?=
 =?utf-8?B?NVBienBzbVdZaUxCejI4SFlMNWg4Z1B6azRjQ3pEOGloTUpHNkpVamcrYUlH?=
 =?utf-8?B?anpxM0g0dDY2aEZrazFlMVJBTllVcXFGak55VlJFb3BESHo0N2c0a051K0Ry?=
 =?utf-8?B?SVNnODROTHlnSitKVjdrQXBremlSUVdDUGJ4OHFPTmNWbXlIRlhPTzZZN0Ix?=
 =?utf-8?B?QmZpaVBjSG5LaWZPQVNjMVI5MkNWM3hJTHB2VnlRVllOVS93SUd2alVNcm5H?=
 =?utf-8?B?ZEs5NCtiWGt3S2E1NXI0YzVsa3AzeTdKMkZpejYyV3UvZ3k4N1NZZDVPeWZT?=
 =?utf-8?B?THhXK1FxMzlqbWZiLzhZT1NGcC9NTWQvMzRUcldBeGtQTGxpVjhSdWVUTjIz?=
 =?utf-8?B?b29aY3NYcHdHeGNXSTZyU09Jb1VyK2YxUDE4OTM2d0xhRnZVWG4xVjc4SjFs?=
 =?utf-8?B?Rm8yOU8zOSswOEh0Um1JSzFBSFpiZDFiRWd1TWVteEhsNlh1OGRtMjR5MXhu?=
 =?utf-8?B?NXJLWUVjQUtoL2k1V2krRkcvV0k0emc1VlVFd2pMeGlndjBJUkcra1VrVS8y?=
 =?utf-8?B?UEdpYzltYlhOSzVCRXM4a3ZtSVErWXVIOS9Hc0xkcHNmME8zNjZBTDFpSkh4?=
 =?utf-8?B?OGRsbFhxMWR2SjMzT0JlNHY0S3lzdEZDU2Q2Z2YzeFNzb2VuM0tKWkFULzV0?=
 =?utf-8?B?ZGtTN3cxQ3N2ZFl3a2ZzMjUwaEVlSjhFdXc5RVVGMDFmUWNBbndTbm4zdWFX?=
 =?utf-8?B?WUZSdzUyaWpFeTdEZERvazE5TDY3MGZqQm9rMnB1dXQ0TEZZb1dnb1p0STBR?=
 =?utf-8?B?S3lCK2w0NGJseko0SWxrQndvNVFwQi9WUC9EbVNaNHlJTzliM0d6WStmQWsw?=
 =?utf-8?B?SmlHa2hTTFI5dmxkVElEdUtnUWg3eExFNThJbDE2V2lPSXdMT0RhdTFaemlV?=
 =?utf-8?B?Mk1pcXdVQmlwYitoSGYwbzRPZ3FQSVEwMHAyZHVsSWwvUmxtUVVUaEhlKzFS?=
 =?utf-8?B?bkt1LytHUjVHZm83UTVVRlMwNmZrbHQ3VHhiWmd6Smd5Z0xOVXJNRXREMDVn?=
 =?utf-8?B?NzZaKzFRVmw4bTlRTklraHY3QzNLTElFa2VGQmI0OG1sbTFveHZIN0ZrVWdZ?=
 =?utf-8?B?eUwyMFJHd1BTZ281UHFnNzBGU1V4KzBiSXlnVHZ1Y1dBallRSWR3d1Fua3VL?=
 =?utf-8?B?dXNad3N2WU9jV0phWEozUVUrMlR3cVFtbkRUdjJnVGhkQXZoYjVnNWI5YVVs?=
 =?utf-8?B?OUp3NTMrK0UzRC9wd3pVcGVMRnNicXNkSThIMjNhRkRIWi9WaG1oam13bHkz?=
 =?utf-8?B?QjczMG51bWpFRGZOVnpiNHlyQUxQZFhlMHZyaUppUExKYmdTYjRqWWRCMGFJ?=
 =?utf-8?B?L28vcE1OOFRYR0NaTThPVnVjSUU5WjMwMUZDUVNPRy9zK2kvSHFXM0tDVmcy?=
 =?utf-8?Q?pZ27g4lg7DaEzdev//c7rBg=3D?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d20a99-48b5-40ff-e755-08dd9e080562
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:52:24.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVTh8e4t1YMu3+Bqy+8EcVXAgvbiw58j9nODAssHJNKeFa6nD5lXMaHZL7d8D5p/WpPTwUu7vpuKrw4gCvX+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4884
X-Proofpoint-ORIG-GUID: cjNdkp1VXPzeyB48LckShlDPcgfRjP1J
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=68373f4b cx=c_pps a=beKarbE+Mk3HYUGHxDyRTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=RpNjiQI2AAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8 a=37rDS-QxAAAA:8 a=JfrnYn6hAAAA:8 a=x0ISKeatAAAA:8 a=LIiwB8tqQRJKC-T0S08A:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=k1Nq6YrhK2t884LQW06G:22 a=1CNFftbPRP8L7MoqJWF3:22 a=4j1IgUSwLGJQIMof3IM5:22
X-Proofpoint-GUID: WtrjJMAGYEt5dlIaOCR2ofpLYgZ30-fC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzOSBTYWx0ZWRfX6yiWi1j+HCUQ KF3ZrGVf+b0ArqiblwAg7BqqSSFWM+FaGc/aftQj19rVZM4FCLh9jO4/m53R3aQDoAlUfpB3Qrz 58ZbARtnuVr8DmXeichu2gILl6pulak66jQ5oAMB1NWf70Dr8WtGj61zZgnMlIN9U3MmXqs9b5i
 k3Bf6zqyZTNkdltBtzP51nFvFzlZ5rc63BlNYAz4c59kP1PdoBtXy2FtWlx2IU7X90J7GUwX/FJ HJyTDrLAtLHLlc8jsIkitMuLaZsfV0EkJ/KNOzMgACGzzqqDvDHAziOYnOK0VJ/sBx8Dc7j19W7 DoriHT8TpdwwiDmjdgLHykLu+qNifCFzTdVWw5radiKBuJtfIcejIJRTDxJ2+8u9Eymnqkh9ZSC
 87EZK2HXm+cjE3noXAGwkjRZ96a8lmccGAcXeUhoW0FVaxyy8rHvcjfLxMmW4NdOcW/W2A2+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [linux-next:master] [mm, slab] 6431f06eec:
 WARNING:at_include/linux/mm.h:#skb_append_pagefrags
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280139



> -----Original Message-----
> From: Vlastimil Babka <vbabka@suse.cz>
> Sent: Wednesday, May 28, 2025 11:46 AM
> To: kernel test robot <oliver.sang@intel.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Bernard Metzler
> <BMT@zurich.ibm.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky
> <leon@kernel.org>
> Cc: oe-lkp@lists.linux.dev; lkp@intel.com; linux-mm@kvack.org; Matthew
> Wilcox <willy@infradead.org>; Simon Horman <horms@kernel.org>;
> netdev@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: [EXTERNAL] Re: [linux-next:master] [mm, slab] 6431f06eec:
> WARNING:at_include/linux/mm.h:#skb_append_pagefrags
>=20
> On 5/22/25 06:54, kernel test robot wrote:
> >
> >
> > Hello,
> >
> >
> > we noticed the WARN added in this commit is hit in our tests. not sure =
if
> it's
> > expected. below full report FYI.
>=20
> It's expected in the sense that if somebody is doing the wrong thing, the=
re
> would be a report. So it seems that has now happened :)
>=20
> > kernel test robot noticed
> "WARNING:at_include/linux/mm.h:#skb_append_pagefrags" on:
> >
> > commit: 6431f06eecf44e7b8d42237cb0e166a456f491ad ("mm, slab: warn when
> increasing refcount on large kmalloc page")
> > https%=20
> 3A__git.kernel.org_cgit_linux_kernel_git_next_linux-
> 2Dnext.git&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhvovE=
4tYSbqxy
> OwdSiLedP4yO55g&m=3DRVwvTs1_4tv9VS6aBY_BN1Nb5XX4P80N9RLHq1UND_lRCm9uja6lY=
Flrt
> 1eIP6xD&s=3DgDBCZ9iGPTCbRHLz-aCIQx6RpCDBnybfljVjh1G_MjQ&e=3D  master
>=20
> FYI that's
> https%=20
> 3A__git.kernel.org_pub_scm_linux_kernel_git_vbabka_slab.git_commit_-3Fh-
> 3Dslab_for-2D6.16_testing-26id-
> 3D6431f06eecf44e7b8d42237cb0e166a456f491ad&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9R=
kVyTcH
> Q&r=3D4ynb4Sj_4MUcZXbhvovE4tYSbqxyOwdSiLedP4yO55g&m=3DRVwvTs1_4tv9VS6aBY_=
BN1Nb5
> XX4P80N9RLHq1UND_lRCm9uja6lYFlrt1eIP6xD&s=3DHgoQP2p-
> qH0YF0Pxt2hT1lLJjQI4CaEArKRz-4OZCUA&e=3D
>=20
> so we have skb_splice_from_iter() calling skb_append_pagefrags() and that
> does a get_page(). But this warning means one of the pages is a kmalloc()
> with size >8kb that is using the page allocator and not slab caches. But
> that 8kb threshold is an implementation detail, so we want all kmalloc()
> allocated buffers to behave the same and use frozen pages and thus not
> allow
> get_page().
>=20
> Note skb_splice_from_iter() has above the call to skb_append_pagefrags():
>=20
> if (WARN_ON_ONCE(!sendpage_ok(page)))
>     goto out;
>=20
> and sendpage_ok() is:
>=20
> return !PageSlab(page) && page_count(page) >=3D 1;
>=20
> Thus if we went ahead with frozen pages for large kmalloc(), sendpage_ok()
> would start marking them as not ok, which seems like the right thing. But
> this callsite would still produce a WARN_ON_ONCE(), so that suggests it's
> not really expected to for kmalloc() pages to reach this code.
>=20
> It's possible that some other code using sendpage_ok() elsewhere prevents
> this from happening, and this WARN_ON_ONCE() is just a safety double chec=
k.
> Or not, and something (siw?) needs to be fixed to e.g. stop using kmalloc=
()

siw ckecks every page before sending via sendpage_ok(). It unsets
MSG_SPLICE_PAGES flag for the current message if one page to be
handed to tcp_sendmsg_locked() fails that test. Wouldn't that
be sufficient?

Thanks,
Bernard.


> and use the page allocator directly. I don't know this code so I'm just
> ccing networking and siw maintainers. Thanks in advance.
>=20
> Vlastimil
>=20
> >
> > [test failed on linux-next/master
> 7bac2c97af4078d7a627500c9bcdd5b033f97718]
> >
> > in testcase: blktests
> > version: blktests-x86_64-613b837-1_20250520
> > with following parameters:
> >
> > 	disk: 1SSD
> > 	test: nvme-group-00
> > 	nvme_trtype: rdma
> > 	use_siw: true
> >
> >
> >
> > config: x86_64-rhel-9.4-func
> > compiler: gcc-12
> > test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylak=
e)
> with 16G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https%=20
> 3A__lore.kernel.org_oe-2Dlkp_202505221248.595a9117-2Dlkp-
> 40intel.com&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhvov=
E4tYSbqx
> yOwdSiLedP4yO55g&m=3DRVwvTs1_4tv9VS6aBY_BN1Nb5XX4P80N9RLHq1UND_lRCm9uja6l=
YFlr
> t1eIP6xD&s=3DDPDmeNRUMUu0ZG0SDNI9LtFWXdtU6aTDbKw4Jlc6V9k&e=3D
> >
> >
> > [  130.177740][ T2674] ------------[ cut here ]------------
> > [ 130.183066][ T2674] WARNING: CPU: 6 PID: 2674 at
> include/linux/mm.h:1552 skb_append_pagefrags (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/include/linux/mm.h:1552 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/net/core/skbuff.c:4518)
> > [  130.192642][ T2674] Modules linked in: siw ib_uverbs nvmet_rdma nvmet
> nvme_rdma nvme_fabrics rdma_cm nvme_auth nvme_core iw_cm ib_cm ib_core xfs
> dm_multipath btrfs blake2b_generic xor zstd_compress raid6_pq
> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
> snd_soc_avs snd_hda_codec_hdmi coretemp snd_soc_hda_codec snd_hda_ext_core
> sd_mod snd_ctl_led snd_soc_core sg snd_hda_codec_realtek kvm_intel
> snd_hda_codec_generic snd_compress ipmi_devintf snd_hda_scodec_component
> ipmi_msghandler i915 kvm snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi
> intel_gtt snd_hda_codec cec irqbypass ghash_clmulni_intel drm_buddy
> snd_hda_core sha512_ssse3 ttm snd_hwdep sha256_ssse3 drm_display_helper
> sha1_ssse3 snd_pcm ahci mei_wdt drm_client_lib drm_kms_helper rapl libahci
> mei_me snd_timer intel_cstate video wmi_bmof i2c_i801 snd intel_uncore mei
> pcspkr soundcore i2c_smbus libata serio_raw intel_pmc_core
> intel_pch_thermal intel_vsec pmt_telemetry wmi acpi_pad pmt_class
> binfmt_misc drm fuse loop dm_mod ip_tables
> > [  130.192875][ T2674]  [last unloaded: ib_uverbs]
> > [  130.286562][ T2674] CPU: 6 UID: 0 PID: 2674 Comm: siw_tx/6 Tainted: G
> S                  6.15.0-rc3-00001-g6431f06eecf4 #1 PREEMPT(voluntary)
> > [  130.299313][ T2674] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [  130.303929][ T2674] Hardware name: HP HP Z240 SFF Workstation/802E,
> BIOS N51 Ver. 01.63 10/05/2017
> > [ 130.312877][ T2674] RIP: 0010:skb_append_pagefrags
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/mm.h:1552
> kbuild/obj/consumer/x86_64-rhel-9.4-func/net/core/skbuff.c:4518)
> > [ 130.318708][ T2674] Code: a2 ff ff 48 8b 4c 24 18 4c 8b 4c 24 10 8b 54
> 24 08 4c 8b 14 24 e9 1b fb ff ff 4c 8d 60 ff e9 47 fb ff ff 0f 0b e9 bb fb
> ff ff <0f> 0b e9 7b fb ff ff b8 a6 ff ff ff e9 d7 fc ff ff 0f 0b 31 ff e9
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:	a2 ff ff 48 8b 4c 24 	movabs %al,0x4c18244c8b48ffff
> >    7:	18 4c
> >    9:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
> >    d:	8b 54 24 08          	mov    0x8(%rsp),%edx
> >   11:	4c 8b 14 24          	mov    (%rsp),%r10
> >   15:	e9 1b fb ff ff       	jmp    0xfffffffffffffb35
> >   1a:	4c 8d 60 ff          	lea    -0x1(%rax),%r12
> >   1e:	e9 47 fb ff ff       	jmp    0xfffffffffffffb6a
> >   23:	0f 0b                	ud2
> >   25:	e9 bb fb ff ff       	jmp    0xfffffffffffffbe5
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	e9 7b fb ff ff       	jmp    0xfffffffffffffbac
> >   31:	b8 a6 ff ff ff       	mov    $0xffffffa6,%eax
> >   36:	e9 d7 fc ff ff       	jmp    0xfffffffffffffd12
> >   3b:	0f 0b                	ud2
> >   3d:	31 ff                	xor    %edi,%edi
> >   3f:	e9                   	.byte 0xe9
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:	0f 0b                	ud2
> >    2:	e9 7b fb ff ff       	jmp    0xfffffffffffffb82
> >    7:	b8 a6 ff ff ff       	mov    $0xffffffa6,%eax
> >    c:	e9 d7 fc ff ff       	jmp    0xfffffffffffffce8
> >   11:	0f 0b                	ud2
> >   13:	31 ff                	xor    %edi,%edi
> >   15:	e9                   	.byte 0xe9
> > [  130.338106][ T2674] RSP: 0018:ffffc90000ec7220 EFLAGS: 00010246
> > [  130.344005][ T2674] RAX: 00000000000000f8 RBX: ffffea00086b0000 RCX:
> ffff8883ffd08840
> > [  130.351795][ T2674] RDX: 0000000000000001 RSI: 1ffffd40010d6006 RDI:
> ffffea00086b0030
> > [  130.359609][ T2674] RBP: ffff8883ffd08780 R08: 0000000000000011 R09:
> ffff8883ffd08848
> > [  130.367426][ T2674] R10: 0000000000000001 R11: 0000000000000001 R12:
> ffffea00086b0000
> > [  130.375247][ T2674] R13: 0000000000000001 R14: 0000000000001000 R15:
> 0000000000000000
> > [  130.383044][ T2674] FS:  0000000000000000(0000)
> GS:ffff888426d45000(0000) knlGS:0000000000000000
> > [  130.391798][ T2674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  130.398234][ T2674] CR2: 000055b575c2cd28 CR3: 000000043c06e004 CR4:
> 00000000003726f0
> > [  130.406050][ T2674] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > [  130.413861][ T2674] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> > [  130.421668][ T2674] Call Trace:
> > [  130.424805][ T2674]  <TASK>
> > [ 130.427594][ T2674] ? __pfx_tcp_established_options
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/net/ipv4/tcp_output.c:989)
> > [ 130.433409][ T2674] skb_splice_from_iter (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/net/core/skbuff.c:7256)
> > [ 130.438455][ T2674] ? __pfx_skb_splice_from_iter
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/net/core/skbuff.c:7223)
> > [ 130.444015][ T2674] ? __sk_mem_raise_allocated
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/net/core/sock.c:3335)
> > [ 130.449674][ T2674] ? __sk_mem_schedule (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/net/core/sock.c:3353)
> > [ 130.454470][ T2674] tcp_sendmsg_locked (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/net/ipv4/tcp.c:1275)
> > [ 130.459521][ T2674] ? tcp_sendmsg (kbuild/obj/consumer/x86_64-rhel-9.=
4-
> func/net/ipv4/tcp.c:1370)
> > [ 130.463786][ T2674] ? sock_sendmsg (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/net/socket.c:712 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/net/socket.c:727 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/net/socket.c:750)
> > [ 130.468307][ T2674] ? __pfx_tcp_sendmsg_locked
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/net/ipv4/tcp.c:1061)
> > [ 130.473697][ T2674] ? __pfx_sock_sendmsg (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/net/socket.c:739)
> > [ 130.478561][ T2674] ? _raw_spin_lock_bh (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/arch/x86/include/asm/atomic.h:107 kbuild/obj/consumer/x86_6=
4-
> rhel-9.4-func/include/linux/atomic/atomic-arch-fallback.h:2170
> kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/atomic/atomic-
> instrumented.h:1302 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/asm-
> generic/qspinlock.h:111 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/include/linux/spinlock.h:187 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/include/linux/spinlock_api_smp.h:127 kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/kernel/locking/spinlock.c:178)
> > [ 130.483350][ T2674] ? __pfx_tcp_release_cb (kbuild/obj/consumer/x86_6=
4-
> rhel-9.4-func/net/ipv4/tcp_output.c:1151)
> > [ 130.488394][ T2674] siw_tcp_sendpages+0x1f1/0x4f0 siw
> > [ 130.494322][ T2674] ? __pfx_siw_tcp_sendpages+0x10/0x10 siw
> > [ 130.500763][ T2674] siw_tx_hdt (kbuild/obj/consumer/x86_64-rhel-9.4-
> func/drivers/infiniband/sw/siw/siw_qp_tx.c:379 kbuild/obj/consumer/x86_64-
> rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:586) siw
> > [ 130.505558][ T2674] ? __pfx_sched_balance_find_src_group
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/sched/fair.c:11298)
> > [ 130.511811][ T2674] ? __pfx_siw_tx_hdt (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:431) siw
> > [ 130.517045][ T2674] ? sched_balance_rq (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/kernel/sched/fair.c:11770)
> > [ 130.521998][ T2674] ? dl_scaled_delta_exec (kbuild/obj/consumer/x86_6=
4-
> rhel-9.4-func/kernel/sched/deadline.c:1481)
> > [ 130.527133][ T2674] ? place_entity (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/kernel/sched/fair.c:5206)
> > [ 130.531567][ T2674] ? __pfx__raw_spin_lock (kbuild/obj/consumer/x86_6=
4-
> rhel-9.4-func/kernel/locking/spinlock.c:153)
> > [ 130.536606][ T2674] ? pick_eevdf (kbuild/obj/consumer/x86_64-rhel-9.4-
> func/kernel/sched/fair.c:946)
> > [ 130.540970][ T2674] ? __resched_curr (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/arch/x86/include/asm/bitops.h:60 kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/include/asm-generic/bitops/instrumented-atomic.h:29
> kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/thread_info.h:97
> kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/sched/core.c:1113)
> > [ 130.545678][ T2674] ? update_curr (kbuild/obj/consumer/x86_64-rhel-9.=
4-
> func/kernel/sched/fair.c:1236)
> > [ 130.550031][ T2674] ? xas_load (kbuild/obj/consumer/x86_64-rhel-9.4-
> func/include/linux/xarray.h:175 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/include/linux/xarray.h:1264 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/lib/xarray.c:241)
> > [ 130.554136][ T2674] ? xa_load (kbuild/obj/consumer/x86_64-rhel-9.4-
> func/lib/xarray.c:1613)
> > [ 130.558136][ T2674] ? __pfx_xa_load (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/lib/xarray.c:1613)
> > [ 130.562569][ T2674] ? ttwu_do_activate (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/kernel/sched/core.c:3705 kbuild/obj/consumer/x86_64-rhel-9.=
4-
> func/kernel/sched/core.c:3735)
> > [ 130.567431][ T2674] ? update_rq_clock_task (kbuild/obj/consumer/x86_6=
4-
> rhel-9.4-func/kernel/sched/sched.h:1325 kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/kernel/sched/pelt.h:120 kbuild/obj/consumer/x86_64-rhel-9.4-
> func/kernel/sched/core.c:797)
> > [ 130.572650][ T2674] ? siw_mem_id2obj (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/drivers/infiniband/sw/siw/siw_mem.c:52) siw
> > [ 130.577866][ T2674] ? __pfx_siw_try_1seg (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:50) siw
> > [ 130.583264][ T2674] ? __pfx_try_to_wake_up (kbuild/obj/consumer/x86_6=
4-
> rhel-9.4-func/kernel/sched/core.c:4175)
> > [ 130.588310][ T2674] ? finish_task_switch+0x155/0x750
> > [ 130.593957][ T2674] siw_qp_sq_proc_tx (kbuild/obj/consumer/x86_64-rhe=
l-
> 9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:882) siw
> > [ 130.599352][ T2674] ? siw_activate_tx (kbuild/obj/consumer/x86_64-rhe=
l-
> 9.4-func/drivers/infiniband/sw/siw/siw_qp.c:996) siw
> > [ 130.604670][ T2674] siw_qp_sq_process (kbuild/obj/consumer/x86_64-rhe=
l-
> 9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1038) siw
> > [ 130.609905][ T2674] siw_sq_resume (kbuild/obj/consumer/x86_64-rhel-9.=
4-
> func/drivers/infiniband/sw/siw/siw_qp_tx.c:1170) siw
> > [ 130.614789][ T2674] siw_run_sq (kbuild/obj/consumer/x86_64-rhel-9.4-
> func/drivers/infiniband/sw/siw/siw_qp_tx.c:1258) siw
> > [ 130.619508][ T2674] ? __pfx_siw_run_sq (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1236) siw
> > [ 130.624735][ T2674] ? __pfx__raw_spin_lock_irqsave
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/locking/spinlock.c:161)
> > [ 130.630482][ T2674] ? __pfx_autoremove_wake_function
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/sched/wait.c:383)
> > [ 130.636383][ T2674] ? __kthread_parkme (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/arch/x86/include/asm/bitops.h:206 (discriminator 15)
> kbuild/obj/consumer/x86_64-rhel-9.4-func/arch/x86/include/asm/bitops.h:238
> (discriminator 15) kbuild/obj/consumer/x86_64-rhel-9.4-func/include/asm-
> generic/bitops/instrumented-non-atomic.h:142 (discriminator 15)
> kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/kthread.c:291
> (discriminator 15))
> > [ 130.641160][ T2674] ? __pfx_siw_run_sq (kbuild/obj/consumer/x86_64-
> rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1236) siw
> > [ 130.646377][ T2674] kthread (kbuild/obj/consumer/x86_64-rhel-9.4-
> func/kernel/kthread.c:464)
> > [ 130.650291][ T2674] ? __pfx_kthread (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/kernel/kthread.c:413)
> > [ 130.654724][ T2674] ? __pfx__raw_spin_lock_irq
> (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/locking/spinlock.c:169)
> > [ 130.660098][ T2674] ? __pfx_kthread (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/kernel/kthread.c:413)
> > [ 130.664534][ T2674] ret_from_fork (kbuild/obj/consumer/x86_64-rhel-9.=
4-
> func/arch/x86/kernel/process.c:159)
> > [ 130.668809][ T2674] ? __pfx_kthread (kbuild/obj/consumer/x86_64-rhel-
> 9.4-func/kernel/kthread.c:413)
> > [ 130.673247][ T2674] ret_from_fork_asm (kbuild/obj/consumer/x86_64-rhe=
l-
> 9.4-func/arch/x86/entry/entry_64.S:258)
> > [  130.677869][ T2674]  </TASK>
> > [  130.680755][ T2674] ---[ end trace 0000000000000000 ]---
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https%=20
> 3A__download.01.org_0day-2Dci_archive_20250522_202505221248.595a9117-2Dlk=
p-
> 40intel.com&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhvov=
E4tYSbqx
> yOwdSiLedP4yO55g&m=3DRVwvTs1_4tv9VS6aBY_BN1Nb5XX4P80N9RLHq1UND_lRCm9uja6l=
YFlr
> t1eIP6xD&s=3D0zFCWDVF-T2ahG-ugOYYBxHQfJHaj8ndY77_YbCzPNY&e=3D
> >
> >
> >


