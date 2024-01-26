Return-Path: <linux-rdma+bounces-772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E687683E044
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186981C22318
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC71200DD;
	Fri, 26 Jan 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShEHh0fM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ODJ6g016"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59A1DDDA;
	Fri, 26 Jan 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290456; cv=fail; b=WusrVwqEoS/2QNQVwzPDtHUm3BOLBPYr/WAA7W4YrjmcsnCTN5JJ/v1oAzeHAt/gWFoGzaBawOVd5kSlTvpBxeDWQN3MLYiCbI2vF1QLiT0RoOrWIc+t6FTpo+/w4sPuVFW4PQ4uvmPw5Gg5tyLrG2LvvfjC9+hBX7HfwpD3znM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290456; c=relaxed/simple;
	bh=7hofzuRhrZgtBbNbKevUGeZLHoDM6ZjpiMd2JV2RrLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CC8ci1JDYllXIKttdCmZ0yNagJ94R1hZyMPJNAr1W7n5S+ShyaOwokdYVbnk9WZb/i3sAkwigdCan9jotb9ZixvUuTpCZfDrssvFyaaloCkgr9jMP7xnWrAqOEoGRjmzIlamMm8+FSGNPZTYUg7isPvqZAABPgpgn4MTQXd3h2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ShEHh0fM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ODJ6g016; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEiSDH000765;
	Fri, 26 Jan 2024 17:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7hofzuRhrZgtBbNbKevUGeZLHoDM6ZjpiMd2JV2RrLc=;
 b=ShEHh0fMU4yX8rgBRJOtLFLi4vZq26af3Wu+GUr502IHiyZwPoGZqflXcOp+bCdY79h0
 zZ7s1amtwuFw0P2gvTZ5SmAx9BBD0SZNmkOTl/6FLMQGQ4+30LTVul7c5QbEPea/UQM5
 y/yjXb0C8KVVXlcA/h5Nvo/9b2IMlSoP9AO4tuCj7Ebz1NccBwKrPyosmSg64Fl9EelL
 mON1Zh1scY+arnSAmww92VnxW0G20Kisoed9U3h1etXLKr6LUXf4Zq/QSA30LRMnIGDv
 7/DeR1RZVzHGzJ9m2cckBLC5tQzH8fZVzLC6RM3b7Rplb0LS3mGgFEayuxnTiFJpjx3v Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ntu61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 17:34:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QFxcqp026074;
	Fri, 26 Jan 2024 17:33:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs31amejg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 17:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neV0RJTYkpdV+SwTLTb5zwYRHHKlmnTL8DnjeJ+Yuw1J0nrjBdcPxUD5y2/YhgeTRQ+IK+LapuqmBzRKQtH2drDWmWEt5qeVW7G1+/r2pHb/Xrt+g1v4ARTtLT4v92XPXRqAiuq2M/9QnAcXGo3TNMmbdkzBJM2ZJSjVnTnnMrLBAU/2wv7XgZ0L8aHj6EKIC1S3H8ZD10GUvb7boDmYKcW8m9RZxngM5mcX9xccTX0jvtVTyhKcKv/GgUesBUdDr6mcJAqnIj4GQpgYMjTBwHwHyZiRt0J3KvDxoiKyWPpe31bDYSU9yxU0WXEbwBbQRfTabKEMVu3nvfXUMAJAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hofzuRhrZgtBbNbKevUGeZLHoDM6ZjpiMd2JV2RrLc=;
 b=bM9645HTZUaG90jWSvvPdazvweDVD8B/d8yfo+XnkFR+WdFt5QnsSVZyh/W6yhGR+eSBloHfGIgpNGByAhotRg5QlElG9tNHqpD6aIXo752PZCxNc+VOzbIDp5R3QmnjsGwjCnHjPeDPyXwFCqV/oDqXvis3WN2go8v+wFlrHWNCiu3pvWIYgmS1TI+wO29zexD19qElAjR7p6NUwzJMOfObbkO3Wm7OqWycUWlI4UpnL1t/qzyzvqYVH1wkf8wA+gkxFl6QucnLmOzeiXxnwmdA10iWtgyLFYbJSVRU7XHYaQQi1zQxGd/OzHzSEV/6yUkOPCj5tUWn0XkFPZGURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hofzuRhrZgtBbNbKevUGeZLHoDM6ZjpiMd2JV2RrLc=;
 b=ODJ6g016rg/ZvDJFzCy5igmDFgqszPyp1rLK03+aebiRWPYKK7rasnMJnwHwm8yLwCKUzQ6JaWK5hCU1MiLPj9QlyQgBd1iIyMnaDdqDwGGZ379c9fLmkpMXyW6wcsqqCp5Sl5khmWX+ljz+oVBMvgsk0+++F+3ULXRfyBT25Sw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 17:33:55 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:33:55 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>
Subject: Re: [rds-devel] [PATCH UPSTREAM 1/1] rds: Fix possible deadlock in
 rds_message_put
Thread-Topic: [rds-devel] [PATCH UPSTREAM 1/1] rds: Fix possible deadlock in
 rds_message_put
Thread-Index: AQHaUHzb3jJU0UeqsUe2ltVgmrhc/LDsWrKA
Date: Fri, 26 Jan 2024 17:33:55 +0000
Message-ID: <64e84a6b3f7e2ac49e171a53b674ae97a6b86030.camel@oracle.com>
References: <20240126172652.241017-1-allison.henderson@oracle.com>
In-Reply-To: <20240126172652.241017-1-allison.henderson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DS7PR10MB5005:EE_
x-ms-office365-filtering-correlation-id: 0d5c221e-6fba-442d-bbd3-08dc1e94f8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QDAaJGlRlDm++v6v5nJUjSw6B82gLHT4TaP6lAOY0gmxzdkwXmHq2El2/BCdBm937bhHoisxmKtmWrd9elKXVr568AHaAi/D/F6xcBhFYk/kApD1/CDBY+h1mzawTlKzTdbQbZUIRP6yqxghKkCEQ05SEWVe8H0tD9bJACsspXzof5jvYsxg0iTCUQFSTZesvBf8hb8A2I1cYVBrw6a3otng3MM5slSYLwYes13nCGfkvy5gf7lCOOlyWLi5oDCVwXeSlKP0jsR/UVtEnZJ+9EsppSvwpos7mP9xN1yJKIXlcPTYEc/Q9iNtPCKmqbRHSddS3/BQK/hTnyE9F0OA5k4S+OC5W3iC7GS5S0P7/pwsyGzff1gkXh0/8NSHSZi9oSCyW2HgwTkEdnq2dqi2exQINIgKBLxObYa8AmkRJDAxjha0PJSVt3z2H4uBZzsHWkJEtOQP0F+sUKbBwM9Or06evnTZF4pt1ZpUo0AaQ0e4hME/0qrh+NunCcNhi6vwL3oRxStRHDKAyOzSkYrlXalI3kHv+FDDeCAHoo7JuCEV7u2UbnxMUZvbOPP0mThwxSTrx5b7S5asf1lDrzDn1IAC9+lr2v/ImoKbxuu5CLHj4x/XjmPOwodN/uvkncxF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(71200400001)(2616005)(6506007)(6512007)(558084003)(86362001)(478600001)(6486002)(6916009)(316002)(4326008)(26005)(8676002)(66476007)(66556008)(8936002)(54906003)(76116006)(66446008)(66946007)(64756008)(38100700002)(36756003)(44832011)(41300700001)(38070700009)(5660300002)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Skx3TUxtYlBiL1Awb3R6eXIzNmJCZUVtTmVObzJaZzJXUTZ6dWhscmk2cmN3?=
 =?utf-8?B?N2RxZlRoSFovdGdlK2xLSkU4dk92ckl4TFVyKyt6Q3pNNCtoT3VXajhoUCtX?=
 =?utf-8?B?MENsR3U1TEswZ1ZmRTg3R3pTMEphQzBKaEtxbEU0aUJXTVpiMkt0Z2VKTnRi?=
 =?utf-8?B?djNjSkNGT3l3TW82QVdNUzZZZjZUVVFseTRFUXBDOUVFVUtsb1ROYjc0T21r?=
 =?utf-8?B?cDNIcURhM1lvbGNPejBsemFFYTJHTmdUblRvR3U2d0hhTHdqVElCM3RDY2Ru?=
 =?utf-8?B?OG5QeXhyRTM3ancvTkIvRC9lK0I2Sm00WkhmSHAyY2wvOWhqTnovWmRsYU9F?=
 =?utf-8?B?WkdkdEUvSkd2Qno1VXFqd1dxN09IS0FXSTNxSEQwZ2VTUGlRZHJCNGVvVWF5?=
 =?utf-8?B?ZEowRDdzSTRrRWJ0ZUhOUmsrNDhkYWJGTTUyZXRjc2xIeDFaNUdlTnZPeEoz?=
 =?utf-8?B?UC96b2YyNW5MTHV1dSsycWxscnh2SlFhYkpYSExaa0VrbWJURVJyRDF2b1pq?=
 =?utf-8?B?d0pCUTkrUWQ3MzdCSmpIeWhnbEpRUytDRjhYa0gveWl4b3RvUk9zTGc5N21D?=
 =?utf-8?B?VXYycjlEak1iQ2kvclpGaFZaSEFmd0JDcENNSzlUSGk3dTlIb1FzYTBpejlO?=
 =?utf-8?B?SDdqS2phdkl1bU1RQmJqZlBRUlVzOGxTVkVXWjJxaGwzZWpYWlI3V3UwNUg3?=
 =?utf-8?B?TEdrU2VOV1QvYkVMQ3draGhKWlQ2bjRQWGVsNGNkcWlYMEM1TG1qZXR4YjRH?=
 =?utf-8?B?ZFZodG85RTFyeS8vVis3U0h5VnhDN2l6bzhjcGlTSHZDZHhvdlhnSHBsVlVX?=
 =?utf-8?B?RXkxeEJlTmZBYUsvYkU5TE1nQUVNL2Ira0NkcHZBdE1HREtJdVVSK2NkaW1y?=
 =?utf-8?B?V2V5dFpQY3RkS1pBTU1QMll3NTdFZGY5aFo3NEhJQ3Q5M0NjRFhpelRrWHlH?=
 =?utf-8?B?YmY4KzBIam9WWG0yaFRnUWpycXBjT0FBTG5GMGhZWVh4K3ZqcUh0QUMvczlC?=
 =?utf-8?B?RVdNVUNNai80eEVjK3hjbEtMdVpmTjZYdWkrVjl5M1RYV2pUSXhEVUhReDRx?=
 =?utf-8?B?TXQ1K1RhTE1GbFhPVFNvUDlrZ1Zva2M1VGxoUm9SRloxdVhCTFR6YnpqTnB2?=
 =?utf-8?B?QXRrUSsyRDRyMXduQmtCVklhTGtQZVhLVzNlYWxZMzRwT1JyeWd0dlAyVUFu?=
 =?utf-8?B?b3BBTklhT1BWOFVLbC9TcGwxOUxydER4ZFBsY3RMOE5BS2tDWmFMS011dXNI?=
 =?utf-8?B?MW14TnVxWUVBd0srQ3lWS1NSMzVMOFFIdEFyaUpZaHlkM3grZ1lGWnlJNFFt?=
 =?utf-8?B?amdwRVkwZ3R6RnhqU3VtU1dSTjFEcDBFTnVhMGM5c0hDWFBQdTJ4YnVwZzJk?=
 =?utf-8?B?QW8zTmtXWGE4V01vYmZHTUtyYkhBNFV5bVdlbG1vRGRNcHhIQ014WVpPdGF1?=
 =?utf-8?B?ZVFtZGtDc1FFcmh2TmhKSFJ0bjA0NkZYeGFzMVcrcFZxaFlTZTNBOHdWN0VY?=
 =?utf-8?B?MHVGaWE0a0taczBMNm03L3JwTGlwYW11U1dxSW8yYmVvSW4wQTFVVjhwZUxa?=
 =?utf-8?B?MWM2M3hKaUhNazNDRUE4eFo1MktnUE44TWRKZ3c0cC9HUU1PTXhrRExjLzZT?=
 =?utf-8?B?dkJDanVXZ3J2cUFLUWVIVjJRYTlJRGlnb0ZPYXc1eVVMKzQ5QWMxY0psVHRT?=
 =?utf-8?B?ZFhQQm95c0RyL3pjMlV0eWJQYjFvYmJjZytFdGdKS0FvUGtYSkkvZXV4blBB?=
 =?utf-8?B?dy9obVlZMUJLRm5OR3kza24vNzVENllUZXAvNGlxMTR2NFlWTHlEOERCYWsw?=
 =?utf-8?B?cEsrbThjV3ZlVS9xSU13V09rS0pxNzNDcS9vWGtucTFQUW0wbVN5UGwzWjJp?=
 =?utf-8?B?VmZFaDhjSGtSSkJCM29jb2gvOU9sN0tCalpmck5wWSt5dDRoTVNHa2JCZjJU?=
 =?utf-8?B?VjBMaEUvcXlwa05ZQmFBV2RMS2NXcDJMTENwNFk3ZndqeW01TXluUVdSMjBm?=
 =?utf-8?B?Y00wcTNTdjNLbWF1MCtHQkFPc3NZSS9helFiVDdLQWtmRjZoVXl3TEsyRjFL?=
 =?utf-8?B?eDA2ODdRMm45aFI3b0QySDF0N0NOc21qK3BHbkxGcWtRZXNCdW93eVNJMmd1?=
 =?utf-8?B?Z1cwUVRrSk9DUCtIQlBTOTNxSEY4c0hRRU5xeW1RWEdjQXN0VlpGNG91S09Y?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A763EA94E2203479E9A7B21FF3D284E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qQxAfaT4mkK/mleD4U3oYKOiSt/+iEFiqBjhnNEUQDuuR9KNmDuLZXBBrbX+N+449yPkavz64OXcBK69cx62Tkr0rEmGcAIOhgvunASPctPU7OyHhuhVeLDkdIaiodM2IJwtEJJspGixokLy29jORMHr71Bhiu+RKsnEmj9MrcoNvmGjlVJmz+R9iwm6MQ0lEymJTsg0opAMeuQs87u+zTlqEfRhRCnyKIZ171rGGPZBDEnPTL243QZqDa1zqdvH5Sb+XpyL5CUrYZnOIoQmIhqqGXJKRpYA+pwWLe6wHNfzeEmEnXXEd496m9S4RN6Ca5Tzc6mVt7aHLWZIbM1lhkTYRO2qVsRK+mjyAIQfwnxv7mYb4iRhtROev19aYXyziSdMNmQvcuI4m1CMtUy8NpwNhC6ZaQnV+A7k1OPUVfx+upOxxn304++6BJdcDvfeZSSkes8VqzzMWyY/LoftwlYx9aDY2GTGqC+MM3RP5eOFdZHFHUPDKBjc/3RbCxCu7/oIDA4TpB6FJLJdazY0NAz36awWfq3q3xEn+gmCCngBL1p3d1r0ROyElZU8p4qMrV0+TAPQ+zZDqKDM28PVaFlVji2TKVeEbr0AVNbUBB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5c221e-6fba-442d-bbd3-08dc1e94f8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 17:33:55.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZ0QVkApBMJivPqr767kOL5TjK7hdfdyLN6ynkPrQj4CJQeCBjxo+zNAUXM+BnlwVpsUVPgOU3fJXDq8vlp6jCSK7HJKgYtKrQfmDbNS5xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=820 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260130
X-Proofpoint-GUID: APoDCFCu_YPRLybPXhhWI2q85rizDFlV
X-Proofpoint-ORIG-GUID: APoDCFCu_YPRLybPXhhWI2q85rizDFlV

T24gRnJpLCAyMDI0LTAxLTI2IGF0IDEwOjI2IC0wNzAwLCBBbGxpc29uIEhlbmRlcnNvbiB2aWEg
cmRzLWRldmVsDQp3cm90ZToNCj4gW3Jkcy1kZXZlbF0gW1BBVENIIFVQU1RSRUFNIA0KT3Bwcywg
dGhpcyBzaG91bGQganVzdCBiZSAiW1BBVENIXSBuZXQvcmRzLiIgQXBvbG9naWVzIGZvciBjb25m
dXNpb24NCg0KQWxsaXNvbg0K

