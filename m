Return-Path: <linux-rdma+bounces-5263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2219927FA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65344282ED3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73F18B464;
	Mon,  7 Oct 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QOf/+K73"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2136.outbound.protection.outlook.com [40.107.103.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D73231CA9
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292834; cv=fail; b=WVI4p7Q+BQuEApJNy/ENHADZtAQb5dzbczEhjA3uhHM0N+raFJMYLaW21WTIqTwMkgDgaw1w7nA9tuaiOYTIyW1dRA4JaZKWE1sHtLMS3tsdXyg7Ztm4/BSgE0mfDg4cmCOfF3goPUCUon3p5LwRtZ+SgcP8bA/4XnGEb+ibp+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292834; c=relaxed/simple;
	bh=cq4sHZF6EuZ2TjPhinmubS7MwTJUJJ+hDzNmnY6LGOs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ku6UBkURc4GAJq9dMo1TqGfetqkb0wZJq9jZpTJM+c/PcgsjMaXJ3xZ81rJGe33sJNj49NNZfh4PmBXR1QYs2/j+NrTZsfsZ1BT9m5Z5D0YbQrP1lJmGb4NbV4UdrPeb5dAeLIU0qQjNKl/J4sM76RY2qBFDBm/2HMxVg7n6ZoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QOf/+K73; arc=fail smtp.client-ip=40.107.103.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj1cA59ycGnEF+6AF1D0d3Ln/YeLowcRLGBC1iK9urgjqTL1ftc2gcw8NGpPxMuN/t6HqO8TWCkCGV0C4KnufJ6bZECDKK3GM96Pcu/qpHZzCCpXL3YttyjlaxS/NoeZ9cln3ArJ3WfUdxeqqhkWsbP0MV/yuKgDrwMlRFjBYqeP0txFHjDBD8OqxVfCEdpdCSliQRycJeBAq264yje5cWMgy9uDIGMyoac0DxE1eN4uEtcN1ndQcmuYw46MdADRRS0Snm8KzUh0V67LNuTmR+h07Ur1LVyUpos2EfcK+oSZClQpdxUgbkrJCiwlVZPLiKDOgFV/rsiTLnZo/fj7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq4sHZF6EuZ2TjPhinmubS7MwTJUJJ+hDzNmnY6LGOs=;
 b=uWOzd50c6yUJ85RZkKKbE8BQ6agJPDkVd0MD/KdMIGhzcn5paXqX5BWg881ZuzJwCQNkmJkq9ck/FtpUzDSMTJgQjKC9OuV+uODgKSgW8oWOe0zQKnZrCyLWfCjsG/RY5khBwik6CO8wCR/LRlj1LURNwdJppGxqtQWjMSocMliPDpM2XByXyxlXfVuRYwiQaLIkFR7IwvpXgGxGQkxhP0UPmisH3U+3ktUa+UywrY5m954NnTfMGSJDK0bEDSV5Y9gU6g1N4d+CbPrTcG3BmcSOyy93NyYxHyWbCjtBPu8Nitz20FP79p34E1gLisfxfPVB9IaF+Nh6OBxqFJpzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq4sHZF6EuZ2TjPhinmubS7MwTJUJJ+hDzNmnY6LGOs=;
 b=QOf/+K73kUzqMmJXivoU+1SsMOU1f2tTJ/rIke6XGEXMC/8dK2GSHfxp/R7xXBzeFUr03hMgMijCnOul1YE2WJCLN+527sPpkR/wADq9N2T9znnpVF0lsYERVr4JH1hN9uNOH9q5L8snwNcHylyUI03HZOP2dA/4ATucmQnkxoI=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI0PR83MB0696.EURPRD83.prod.outlook.com (2603:10a6:800:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.2; Mon, 7 Oct
 2024 09:20:29 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::c3a:b7f9:46e1:aca6]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::c3a:b7f9:46e1:aca6%7]) with mapi id 15.20.8069.000; Mon, 7 Oct 2024
 09:20:29 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: IVANE ADAM <ivane.adam@univ-grenoble-alpes.fr>, linux-rdma
	<linux-rdma@vger.kernel.org>
Subject: RE: Performance issue for a simple RDMA PingPong
Thread-Topic: Performance issue for a simple RDMA PingPong
Thread-Index: 7V4j/ibp8zPuE0UrjnmckwbJB/ACJPnpN/3g
Date: Mon, 7 Oct 2024 09:20:29 +0000
Message-ID:
 <PAXPR83MB055997D73EFC57599EB67E84B47D2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References:
 <1837235494.9324983.1727941451114.JavaMail.zimbra@univ-grenoble-alpes.fr>
In-Reply-To:
 <1837235494.9324983.1727941451114.JavaMail.zimbra@univ-grenoble-alpes.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f5f9f8a9-e404-4448-b69d-d97f16da1ce1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-07T09:17:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI0PR83MB0696:EE_
x-ms-office365-filtering-correlation-id: e2c828bb-ffa0-4791-e130-08dce6b14942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTZMUHdVSzZyTVNXL3NSY01DMjJpdG95U3FNQzdnd3B0b3NTbVcwWmR5OFQz?=
 =?utf-8?B?U1hmc3BsZTJBQmcwTXpiTFVmMnp1QytXaFJiWmtDNjlzS2tKbGJNSFVqeTVv?=
 =?utf-8?B?VlR1bitEZjUvTXczL2h6VEI4cXJsWnNWVEZ2TEcxMHFwQ1BMa2xSdkNycnR3?=
 =?utf-8?B?SnlOa244cjNRV052RkVhUWZsTmo5V1NDZzUrYjZsTnB2MmRjcEVoaFpMTEE1?=
 =?utf-8?B?WlJBd0hSbFB4NzJmZkgveDBPTTcyVFFIOFBGdWFsRUFaUG9ubWlVRkllTW9X?=
 =?utf-8?B?U0VGenZSTTdzZGxNZ2x2Ynk5YXBOUzlQbUF3UUpkY2ZyQnhiRXVWV1U4RkVj?=
 =?utf-8?B?bHZjQ2tSOS9GTHFKVldxbWczUjJQeFprdUY2WkR4cGJ1M2N5cFMzelQ4RXhV?=
 =?utf-8?B?M2JVcVY1bTU3c3ZLeTFMRW9kdWVvVWdtM2ppSW41VEhVNkFKK1ErdXRXVWZu?=
 =?utf-8?B?cHdCZCtvaDVYMS9saE1hMDA4VWRRUzJuL0xKZDhnOGlPVytxeHpIRE5aTVlG?=
 =?utf-8?B?amtWWXFRRHF2SnNPUlRMRkNsTVNFeVFtWi9YaVk0cWwwMEc3bXI5alZBNUxY?=
 =?utf-8?B?UmdMRGlZU0l5L0VldVYwQVAvUitNRS9adVpDNTdhV0M1YWRhNElYTHYvRXdr?=
 =?utf-8?B?UldLMmZId0RDQnQrL1pLR0Z0cUNsbHppcEFrS1UzZ1FZbmYwY0JSc21IcHBQ?=
 =?utf-8?B?dmVWSUY0dGJwa0dZdGZXQ1p2ckVlNXB2eTRuUW5YZEVVckpVcW1LODRDTW0w?=
 =?utf-8?B?dkRsaE5TeEFCTmV3L2dzdmkycktKNjc0YzF3MWpCNzJUUjZ6SnZvYyt4RTJT?=
 =?utf-8?B?RnhhOUxIZG5oTUhVUmo1bHNkbDRyM1B3S1RmakIvbmpHWmJVTVU1Tlg3UmZi?=
 =?utf-8?B?djdPc3FLZm14aWtpNHF0dVExMHFsRG9LdlkrcEdCVCtObUZhcVlyRi9Wekxp?=
 =?utf-8?B?V284R3hLaGVDNUtHaW9qeXlRWTRuNkQyNWFrUTJOSVVqMVlYTUh2QkJ0TWFM?=
 =?utf-8?B?KzlQejA3M0NBcGQ3dzZPa3Q1b3VSNkVlanIzUUhHZGFZSWlxN1dDaEFKMHln?=
 =?utf-8?B?VnVOb29IalJqWGsyUFp0RFpVa3YrMlpnUGxxQ2lxNElTeENtdHpCbUZGWnpS?=
 =?utf-8?B?WWFjWk9vbmFyNnBJcE1vRWl2a3dHd1VVOWpadVFqNHduQzdCbUZ4TmJ4cThS?=
 =?utf-8?B?WnBGWVJlVHBzWGk2a09FWTdidkJFTnEvelVhRFNqbmV5d01MVHUzdjQ1UThN?=
 =?utf-8?B?M3NqRnZCZ3ZUeFRNemVGQ05uK0JEZHR3Tzg0R1NiT29yeXNJdmlOVUdDcUsy?=
 =?utf-8?B?UkhoTDByaG41bWhuVW42RlZ1ZjRuR0RTQWJOTFduMnJNK0Z3ZHo1aG5UbXNu?=
 =?utf-8?B?dVMycUt2cWQxU0FiajJiKzNEYUxkWUtBUEFGVFFuT3N5S3h4QW9ZNzM4bXR4?=
 =?utf-8?B?ZTBXL3EwbVpWeHhDbS8vQlhQYUpUVkNySHlZbW9FUFlSbmVqNSttSGVxb09C?=
 =?utf-8?B?Ry8xbVA1MHVlSWZqK1B1SjdXU2o2bEpTRWJ1SEFlc2h0UURDNy92eDlQRnRa?=
 =?utf-8?B?ZnVta3FKUTB1dncxVlJTdlFlNmoyeDRTZlhJQ2k1MlhtTldERHdPRi9LWmdP?=
 =?utf-8?B?WnBmTDQwMXlLaHdJR0UydXlBQ3p1WGN2M016R01EOGdnY2xHUU9RTFNnQ3pm?=
 =?utf-8?B?Z0dJdVdnaTEzTkZBcVVhSFlOdVFJeDdLTUZuTmhYUWFjbTVEc1l2RERSZ1RP?=
 =?utf-8?B?WTg5Q24vYXFZWDVxSlc1VG1jVWtQcmw1YXhEU2l0Mlo5Y0dXT1EwZjc4WXAr?=
 =?utf-8?B?Z05qS0NWb3VBbGt4b2dwdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1F2SzNEeERNL3U1a2FGZ1FyNWZ6aHlKaVgxRHpUZGlUVmJCcExIRjlvRllu?=
 =?utf-8?B?THpDRzNGSVp1RmxXVDhLUDNBeHE4a3lTTVNFNGhEU1RyQ0NVQktqeXJDcGEw?=
 =?utf-8?B?ZzNCNkY4eno1UTZTTTdwbmhDaTNKeVdHRTB6NHREeTVrb2RZRVM2dVE1cjdX?=
 =?utf-8?B?WmZPQ1hsU1dWZ0NaRklGQVZLcmE3SXpRc2NJM01SQ1pIRmFGMU9BVWJjNEJo?=
 =?utf-8?B?UFRsVEdVQWdvbUJnQ21VOWVZbmdxQUdWZURMOFEzaG5zMnBMS09nVWNES2R5?=
 =?utf-8?B?MHNjbkMyTlRwT05CUytHcVdCc3R5L1ZjeGZDRE83WVY2bGgwQXIvRWJaWFo0?=
 =?utf-8?B?YjNDdXozcU54RlVETEw2MHRvVVEwS0VyRUxSZkVzZmE5cTNlMDFiNTZYKzV1?=
 =?utf-8?B?SC9RbGVLaEREbFVlbHhOUENEUVFJUy9HT0c1emk5WnFxOGFaclpGZkQzRjlk?=
 =?utf-8?B?Q0VJTUg2dFhvQUhuUGJWKzdNTjQ3dkVaVFV2VXFiS0lVZTBBMk0wZGw3YWtM?=
 =?utf-8?B?a3F2WTBaSGlEblpEcWxkODZ0bDg2RTdyMVE5QTBrVklKNTV6M05CL0ZIb0NZ?=
 =?utf-8?B?VGlZVWxweW1JUXBjU21LMmdmWmNEWk1EY2EySWFERGxMYng4cGEybVg4TWp6?=
 =?utf-8?B?SEljWmkxOXF3SEVoSndHMVdESjFtSlI3bGN3UGsxVkZLM0hMQlpjMmwxSDho?=
 =?utf-8?B?Q2dNS0xtU0ljUU54UTg2aVlYbldUVU9SWDRzWk04bDMwSWZkZVFGZ3RyOXh6?=
 =?utf-8?B?NHlxRHVtRTI4UnFPTGRSYkRJSjh5bEpHZjgvS21NbTREbzBsQU5lMkNOcjlI?=
 =?utf-8?B?RVAvVzRxclV0NFUzdTVRd1h5OGJ6RFpSbW40S3NjbzVhaDZSYWVwaGxXUDBV?=
 =?utf-8?B?eFEyNEYvc1lhakRacmhvWnU0V2E0clQ1dHdVaVB5cjdVWHBSTDBRTFRYeTFQ?=
 =?utf-8?B?ZGR1TlpLYU1zcTdZd3RkYXduWGlrS2tFK20vYXB5VS9abXNSaFlDMkhPS3kv?=
 =?utf-8?B?V2h5VCtvN1JGYmVKdTE2azBNZXBaWnBTY0k4WHEyaVVrQWRTRWVqYjAzVTdF?=
 =?utf-8?B?VmZoYkRydk1keWQxREpCWFZsYU5tU2JJdjg5bHZxQmtoOVNLckRjOFl5VVcv?=
 =?utf-8?B?Qnh1YVF4ODJKaEdXa2ZON1ZZWlZMclpuQ2NsQUlvMVZNMTUxaUJYdHZTR1dY?=
 =?utf-8?B?MzhmSXFURjNhOGxVdVFnbXdOdVhWTCtMK1EzWjhVNWhxZXdla0tyV2lEQ0JO?=
 =?utf-8?B?V1JMR3Vva040OVpWVkVBRkR0MjFkL0ZMaHNRUjVNd1RxNHJMUFh3YVgvbmNP?=
 =?utf-8?B?cmVseUkvRXBYVVR1eVFrZDdjQ1A1aHZZNk94amhuY0x6SVVzVGVpY2lZRWcw?=
 =?utf-8?B?dDhoMFgxZGZoZEJFczhKYjE1Snd5WVJMK3Fvc3dTZEF1Ui9OaWNRNTRpK05P?=
 =?utf-8?B?REJZdWdqVWgvZTRkZUFXYnZBbEdMSkNVQ3V5cVZ3cWZHOWJXQnUyMVZUTEZB?=
 =?utf-8?B?SVdMSWN4NndOUjU0bkxhd0o2eGtnNktWR0pUTENFWnhxNTFjVVdiYndDZlh1?=
 =?utf-8?B?NXcrYU9Fb1dKbEdFaHQ4UzJWNHAvK0swWmlzS3B0VXEyVU96OTVrbzEraHk0?=
 =?utf-8?B?M3JCeVFqRi80TEQ1RTkwVFhMZzlpUTVGWUtRWHpyaG5PRXg3RkdOS3BEZndC?=
 =?utf-8?B?QzZseXpIdVg5ZitySzhhMThaRmlFWmJlM1h2SnhDKzd3NkdoTHVFMmhaTDl0?=
 =?utf-8?B?QWd3T1htZEh4NThmZllNUFJJZ1dmNDVrTVpkdFFqcjJPb0RsOHBBUjVDYU1u?=
 =?utf-8?B?YisxUjZrOVBXOTRCSERmWE1JSmVFUzArYkZCZ01wMkRyNFZjaCtEYy9ZbzBk?=
 =?utf-8?B?emc3U0lPY1dxb0wwUm9PcEdQcEN5V3JmMTBNNFNwZHIzTkVaOElLOGplS1Zq?=
 =?utf-8?B?NVFZOTdlNzd1YlVvTTNOQXovUzY0dndrOTZRUDRMT0o3Z2NVRlhkdU1Qaitp?=
 =?utf-8?B?Z3drcW1GcUF1UFJybUdZVFZsOUxqSVN6UmM4TU5MblNLVWRrcHpXZmE3Q3ZR?=
 =?utf-8?Q?NUbloP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c828bb-ffa0-4791-e130-08dce6b14942
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 09:20:29.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0v2ZjUOQyLhAPNwILUYEfAhkLkNCtSmdBKjghv68jpNAnHrIXYNSafdthw4wz/Pjn014Td0hobnNvBsKL1Uyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0696

PiBIZWxsbyBldmVyeW9uZSwNCj4gDQo+IEknbSBjdXJyZW50bHkgaGF2aW5nIGEgcGVyZm9ybWFu
Y2UgaXNzdWUgdG8gc3luY2hyb25pemUgdHdvIGRpZmZlcmVudCBub2Rlcw0KPiB3aXRoIGEgc2lt
cGxlIHBpbmcvcG9uZyBhbGdvcml0aG0uDQo+IEkgY3VycmVudGx5IGhhdmUgdHdvIGRpZmZlcmVu
dCBzaW1wbGUgY29kZSB0byByZXN1bWUgbXkgaXNzdWUgOg0KPiANCj4gVGhlIGZpcnN0IG9uZSB3
b3JrIGFzIGludGVuZGVkLCBhbmQgbG9vcCBhcyBmb2xsb3cgb24gYm90aCBjbGllbnQgYW5kIHNl
cnZlcg0KPiBzaWRlcyA6DQo+IC0gcG9zdCBhIHNlbmQgd29yayByZXF1ZXN0DQo+IC0gcG9zdCBh
IHJlY2VpdmUgd29yayByZXF1ZXN0DQo+IC0gd2FpdCBib3RoIGNvbXBsZXRpb24sIGFja25vd2xl
ZGdlIHRoZW0gYW5kIGNvbnRpbnVlLg0KPiBUaGlzIGxpdHRsZSBwaWVjZSBvZiBwcm9ncmFtIHdv
cmsgYXMgaW50ZW5kZWQsIGFuZCBJJ20gYWJsZSB0byBjb21wbGV0ZSAxMDBrDQo+IHJlcXVlc3Qg
aW4gMuKAkzMgc2Vjb25kcy4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBzZWNvbmQgY29kZSBpcyBhcyBm
b2xsb3dzIDoNCj4gVGhlIGNsaWVudCBpcyBpZGVudGljYWwgYXMgdGhlIGZpcnN0IGNvZGUuDQo+
IFRoZSBzZXJ2ZXIgZG8gOg0KPiAtIHBvc3QgYSByZWNlaXZlIHdvcmsgcmVxdWVzdA0KPiAtIHdh
aXQgaXRzIGNvbXBsZXRpb24gYW5kIGFja25vd2xlZGdlIGl0DQo+IC0gcG9zdCBhIHNlbmQgd29y
ayByZXF1ZXN0DQo+IC0gd2FpdCBpdHMgY29tcGxldGlvbiBhbmQgYWNrbm93bGVkZ2UgaXQgV2hl
biBJIGRvIHRoaXMsIGl0IGhhcHBlbnMgdGhhdCB0aGUNCj4gdGltZSB0byBjb21wbGV0ZSBhIHJl
cXVlc3QgY2FuIHRha2UgdXAgdG8gMiBzZWNvbmRzIChtb3N0IG9mIGl0IGluc2lkZSB0aGUNCj4g
Imlidl9nZXRfY3FfZXZlbnQoKSIpIEZ1cnRoZXJtb3JlLCB3ZSBvYnNlcnZlZCB0aGF0LCB0aGlz
IGhhcHBlbnMgbW9yZQ0KPiBvZnRlbiB3aGVuIG11bHRpcGxlIHRocmVhZHMgdHJ5IHRvIGRvIHRo
aXMgaW4gc3luY2ggKHVubGlrZSBmaXJzdCBjb2RlKS4NCg0KSGV5LA0KDQpUaGUgcHJvYmxlbSB5
b3UgZXhwZXJpZW5jZSBpcyB0aGF0IHRoZSByZXNwb25kZXIgZG9lcyBub3QgaGF2ZSByZWNlaXZl
IGJ1ZmZlcnMgd2hlbiBpbmNvbWluZyBzZW5kIHBhY2tldCBhcnJpdmVzLg0KVGhhdCBpcyB3aHkg
eW91IGRvIG5vdCBzZWUgaXQgZm9yIFdyaXRlcyBhbmQgUmVhZHMuDQpUbyBjaGVjayB0aGF0IHlv
dSBjYW4gY29uZmlndXJlIHlvdXIgUkMgUVAgd2l0aCB6ZXJvIFJOUiBOQUsgcmV0cmFuc21pdC4g
KHJucl9yZXRyeSA9IDApLg0KDQpZb3UgbWF5IHdvbmRlciB3aHkgeW91IGV4cGVyaWVuY2UgaXQs
IGFuZCB0aGUga2V5IGlzIHRoYXQgU2VuZCBXQyBpcyBnZW5lcmF0ZWQgYWZ0ZXIgYW4gUlRUIChh
cyBXQyBpbmRpY2F0ZXMgcmVsaWFibGUgcmVjZXB0aW9uIG9mIGRhdGEpIGFuZCBSZWNlaXZlIFdD
IG9uY2UgZGF0YSBhcnJpdmVzIChhcyBSZWNlaXZlIFdSIGlzIGNvbnN1bWVkKS4gWW91IGhhdmUg
dGhlIGZvbGxvd2luZyBwcm9ibGVtIHdpdGggYSBuZXcgY2xpZW50Og0KDQpUaGUgbmV3IGNsaWVu
dCB3YWl0cyBmb3IgYSBTZW5kIFdDIGJlZm9yZSBwb3N0aW5nIGEgbmV3IFJlY2VpdmUgV1IsIGJ1
dCB0aGUgc2VydmVyIHNlbmRzIGEgV1Igb25jZSBpdCBzZWVzIGEgUmVjZWl2ZSBXUi4NCkFzIGEg
cmVzdWx0LCB0aGUgY2xpZW50IGhhcyBub3QgcG9zdGVkIG9uIHRpbWUgYSByZWNlaXZlIFdSIChh
cyBpdCBzYXcgYSBTZW5kIFdDIHJpZ2h0IGJlZm9yZSBhbiBpbmNvbWluZyBTZW5kIG1lc3NhZ2Up
LCB3aGljaCBpbmN1cnMgUk5SIE5BSyByZXRyYW5zbWl0Lg0KDQotIEtvbnN0YW50aW4NCg==

