Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE76FF6E5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbjEKQQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjEKQQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 12:16:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3AD2681
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 09:16:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDx0bJ014448
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 16:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2023-03-30;
 bh=T2cE8kCpteTlHC1uVDMRoD5L0Rh7Nx8J2GL0i69nhxc=;
 b=Jn/HfaKUWjDOglNJaGLY+9gVcaKM6DgM5TeWjr82SPRbXQsf8k7XnVIRKnL5wOrORjB6
 2iPnp/ekYmno2KPClFfgZppBdDprOa7Eaoc+z38tKRupTkcrbx8JmXBCL6zfoK2imSeN
 UxzzjiuCWfGiyYJet3afa0opQU44eTK+3McP78oWsmMZ93f+rF6dWb65rkwl0sQhgEJx
 ir3mCtlNTYwV04QzppnemFq6bLMk2SpxQeD4w615tNW89DmCnt/Z5jrp/Ty3rNRkUeJH
 06buUcHIATV+flME7ErIFVavrwXnXT6FP5MhN07m0Qc+08Wd8Z//d0g1KWMS1XRU90LE Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c7p2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 16:16:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BFAaeB004650
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 16:16:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pm7p5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 16:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIznnNiULQjgl6YBD58Ijr8YbitgCTtJRXSuiiAMtKTg4AtnCNBQFbhs9x1W5OvU18KErplHJH+tPpL5VuQAKVT1+G4A/1gdXn+4zvtdYNJ4lU548/gm4sYbG9nKfwhEdEwCl8B6NlDyt/Rv1YlWHV6EYW/KVH1eA426bFa6L/L6e5fm9l2ZH9ZB+v2D+EznNMhoKtr/Oky3W0REkXa6Ob6dtrjwUJhHLSoT+4PJ/LKA9hjQ11BEWSISOXNBgDZ9kT77+8rkLgkQgsmNR/aAxuwTjuzKhj7bt8UwFHZn2ZbxvpxMQc/AQ30m1harYPiScViwhz6jSlqBCnEVJsf5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2cE8kCpteTlHC1uVDMRoD5L0Rh7Nx8J2GL0i69nhxc=;
 b=SFI2FXWzW3bjzkV2Ay2zl1wPqFcVwwlpxIczZqsWEwYsUICM8RWyvHcTPDDL/gbuBSdQAouOiMDp/xTokySbvBKfLfrAG6bt/nuHRzuu5ZwHlkJCCXHB958oiuTNmOxZcCu/BZEWa2PiABcXSB1FPezhPNL87oHiTBxEwH4dgg0krVZg3JX3oxhkGRUUwKUuHipJBK8p8YlRUZrbFtPcngLqc+UVPuuMSHN4XAisM/DquJCUUv2BCtLEccVEso0blZGwdQTMfOCsrWLQhLD1sXPiMmsw3z+vR9MP3QwYxTk3puXclzmEsY63pymKWTV9crEw72QNcheMd+RsIJrP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2cE8kCpteTlHC1uVDMRoD5L0Rh7Nx8J2GL0i69nhxc=;
 b=DxN+Fk0y+/4Js2WQP4UvHwwFyPm5IRUckL4DwAVyX+ZlSTTKxXwr2JE8Pvkr5XlhvXCLUf5uahtzZbs5msNaA+1wDfnFtSefrbjG4Hm4GibmUHylJA49ycZgZSWUZPFGFPKE9S2luHC6KwGii7Nlfz6uqXvZfOQD55C2456aVJw=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS7PR10MB7348.namprd10.prod.outlook.com (2603:10b6:8:eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 16:16:16 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::e53a:31e3:d66d:6fdc]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::e53a:31e3:d66d:6fdc%2]) with mapi id 15.20.6387.018; Thu, 11 May 2023
 16:16:16 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Question about SQD in the mlx5_ib driver
Thread-Topic: Question about SQD in the mlx5_ib driver
Thread-Index: AQHZhCPpzP5NkmPmMkaCIUtfHtdacA==
Date:   Thu, 11 May 2023 16:16:16 +0000
Message-ID: <6F7F6F24-2AF7-4BBC-9D6C-70C8CC451A3B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS7PR10MB7348:EE_
x-ms-office365-filtering-correlation-id: 15d0d5c2-e20f-4ee0-36c4-08db523b0c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E44pGnuULFAG4vPGbrczpLvOba/5P+TsX0fL7dIx5rzeE3xzlV4l4IDa0CVGAG7OuA83FNcv4Cp05TUfgcnSaIzn2/FhJPoAmECXNmsQm2gglglt6RPU3O0qAiSIC3hEB9hGsp7FIzT6b0JzQZ9WFRXbd5JKjyMoiM/CznjtxL3Do3M1SIFFnDN4tIIjpDDW4vZ2JaHz44fjGeP1sVwplqosGjWHWFtHKj9hQLLds7DevHu7TlH55Tv1IhC3xTPU/IbW293IZCQSs1eKcLF5WQgI7zuDTIl32jc8HvzwwCdwk1lMLEm26+VRUSKDL86K+UDSYIF/ZcLbdPS1/wJW1fGGk7tPX1HoBsVTRcgGEKqT2w4WXhfuHL3wycMMrDKu8nb1SCPXB23/HSkqxcJQKBSZdBd3v1f/08ItzV+m/bslSDzdYGxNa7M52n/G3HP3JGGvgjvpkNVadod1kSVtN8F9o4i3lmF3M2Dm3V6UliI1bmha604q7zEviQ4E9jbSzQ4GAvWGYeFFK9XTg2r3b/Zq6HggIE9Ia1B7QJZSy8yW6f9hkLqIuUj351RbChQIjzc2YNc4clUJy00SzFsznoJz5yip37fsQgTfvMuD9bQh4YkpXFinihmHThGjEbuh8+TQGGFMUjJwWXEwW7b78g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(558084003)(36756003)(86362001)(33656002)(91956017)(316002)(76116006)(64756008)(66446008)(6916009)(66476007)(478600001)(66556008)(66946007)(6486002)(41300700001)(71200400001)(8936002)(5660300002)(44832011)(8676002)(2906002)(38070700005)(38100700002)(122000001)(6512007)(2616005)(186003)(6506007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODBPcGRTWWlsNjZoSjAxWXNkVlU3NFJpWkF3VTVTMGJQM0FLWjlNWDM1QzEw?=
 =?utf-8?B?Y0djRXpOZExsREx2SWJxZ3U2aDQzeEVDdXIvZXg5SGV1bzR1aVYwb0JCMkxj?=
 =?utf-8?B?OEoxUFVoM0VzM09vdGNlc01tWEp6MUlrYXJMTXBkL2J1YVptTXdSMFFuRi9Q?=
 =?utf-8?B?eEw2U0UrYzZRQ05xZEQyM09kLzYwQkFYUEFJUlFML0gxN2duNnZ5bTF5T2RS?=
 =?utf-8?B?MDdyMitNZnhEWmFTdVJ3WkZpU0lUVEF2QXlBV3NGTmNvbkhKMEJ1NEN2bVNV?=
 =?utf-8?B?eDRGaUdzQitYSlhGVE55QWMzK0lYRXB4amwyZUN5amU0WUkvRXpmWEhNRWR3?=
 =?utf-8?B?d3BRVG9tUzR1aFZjS1MzUEhLTmxrOGZ4NUptUWJrS1kzSHJpZnVjK0dpMEFx?=
 =?utf-8?B?VjdxbThmODlWRTJySFFiTGdHa1VhOTF6K2NMWkREdGZtaHJCaENBTlhSdGRT?=
 =?utf-8?B?bE9YOE5mMFI3VDluRjg0RWRsWU5xWXI5UjN5UDBTZytKM2FBQUJiUVQwUWt5?=
 =?utf-8?B?K1h0NHo4UlROYkR6bXFnU1Z4MHBPSFdmNllzdW10dWVuR2FGQWFtaHUvSXNx?=
 =?utf-8?B?ckZ3TlJwRE94aFFYZUVhZFdGZDhxbVJhSkRjenh6TWdXUGkrNFJrZFB3VDRh?=
 =?utf-8?B?RDNRMFpGTS9vN3RvWlB2WE9qK25WUzMwL281Qk9aWEJKUURjRnVBSUFHVmZT?=
 =?utf-8?B?S2dMS2tLVVpQZjFTV0pibWEybU1XQWNGOU9RVXBMamRlQlV0VzdiejFFRkp6?=
 =?utf-8?B?VHFRL2lReDN5SmpwOEhpeGlpRXRDczVKR25BMHBTL1dLZ2R1LzZRZm5jZHhQ?=
 =?utf-8?B?a2dsd1BZc0FJMTk5cUsxNVhmVStpemw3dnpsN1BIekdmd1greUlaSUtJbVpm?=
 =?utf-8?B?NE9tbThxMmRoV1B0Q3ZwZURYRHpJU1c3dlY2blN4OUMrelBmaEk1UmtDQ0xC?=
 =?utf-8?B?K0hYR0VKZ1J5VkFNM0JJclBqZFFsRmVNVmt6SmM3ZS84a1hLTlpZMjhHaUo5?=
 =?utf-8?B?QUp0bHpLTCtKeHA1QXZoWlV2Y2FORnhVdCt1WkJjeHBlbisvYXBLTzNqVXAy?=
 =?utf-8?B?N2FEWHNXSkRXQW0rUWR2T1czVEthTGg3SjlKZ25QbDMwR25mNGh2dnhOZzI2?=
 =?utf-8?B?cGUrV0xmSXBReTgzWkNwUXdaS0FKN3FyU3o2N0ptKzJuOWNYL2pLRlpHRXlC?=
 =?utf-8?B?anhXN2w5VFFoaDl1Z202cmlIaHJxMHNNZFlBMzhodFpiUFRoTkplZjBaVVdO?=
 =?utf-8?B?MGcyajdMWG5BUFIwcFB0aXZCVXJiUFNMS0hyTDBEcXAxdWZOcXlIRUw2R2h6?=
 =?utf-8?B?ZVVuaGk2RnJVblExeGZ6YXFobE9LOWowVWoxRmthRWRYaXgxRUZEUU55Nno4?=
 =?utf-8?B?K0dJZ1VZOTZ3eU9ESmdSY0VXbUNYdDhsczhvTWpZK08xVTh5cHZueW9GZ3pH?=
 =?utf-8?B?VE1pVHU1eWd1Y0k0R1VtNTYvOGFTNllCMjVLTnRCeHYybm9Qem9qQzN0MU4y?=
 =?utf-8?B?T3FYYjB1am5zeFFhYVBJcjVrY2JyU3VpcUNURjJKZEFsWklzV0ZlZkNWVU0v?=
 =?utf-8?B?Q28xUXNTNlh2d2xrWEhDYm0wTHhBMlhQMEZ2SXFRTVNuSjhvdHBoVG1kV3FY?=
 =?utf-8?B?SVVscUNlK0ZpanNRUE1mVDNFc0J3T1o4S1FaRGVNNWJRQm5XdGd1SzlyeWND?=
 =?utf-8?B?OGtFcms4d2pTdVJMVTVxaStKMXNtZ01weTRQWGp4ek5Rb3FmT2REU2x6SXhP?=
 =?utf-8?B?ZnZUUDdSczNjWVFuc1h2S29NVEd6aEJLbmVxRERPYjJKQXN4SzZxNTNmTWVY?=
 =?utf-8?B?ZFg4UkZwUXMrWUJMMjNRM2hHbWYra1JJMVhjcHpsbHZGWW5OMlpFUE9uR09Z?=
 =?utf-8?B?QjNEeThPOWNjdXIvTjZla0lxR0xxckh3NXlqQmtGODAydzdUOHYxVDAwSHMy?=
 =?utf-8?B?UVgzZFBGOUk0U2ViY2hleXY0NWk2eXYzOGhBT3Mrb1BoejFBK0RrVDlONW1p?=
 =?utf-8?B?cWlIVXhkMUVvazZsN0NpWnpXUXdHUDNTa05odFUzbDkybi9hc0pYZHZYT3lC?=
 =?utf-8?B?ZUQvcEJ6S1c2V3FXMU01K2JQQUUzUWdFTDIxekJWdHRZUFg0RFF6Q3dMMUly?=
 =?utf-8?B?NlVCT2trcFNrSWdRMlRXanVkWlFhLzBOOUhZUzJGRmVvOTRxUUkxYTlzOFpE?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F8A5DE503FB7B4EA8FE6A02AFAD358D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FEtU2L2pq29J0UhTAZYE/vLDmbHJKYTM5LMR/bylKGaXj8dN7WRZJWvrILE/O1RrmTU/fN0XCCWiigTKBi5SqSXmYkJaUaP4wSj3niP4itOBEUZLDFieZdq1GdCV0Nrf6LPaFJ9O89EAk1id7Z2RokbeusSBraRC26SNPuRuTfiezYlqDhceCbqCYf9Odjadp5U2dz2h9OUQ1H3oCM29ZccqgMS4g8s42Eie2DPKyDh6M1j2W1orBNJbC2k4GA3KNyro0bjtcALxo/nhkM8O9IOWHMU5DvSvpkwsK+aKb86IVZiVK2CQF2+KcAA24hX0Oxt2dBpkIFBksyvxnrsm5MOP7PtsagO0QgxJf2Yjzy59/O5+HSKUzDUIRRpZMA69uOSesdUdm3UH65702aUkySPvV4WELjvGzrcxa6bcCd3WdHyRcfP765CVWm8h7W/JRl0V+XYfZeVRk3QUCUBBysMhlUInyUcg5oEIbPufV+GvvJD2vP36dt61gyFvYDO3RmRPwnjjsCAyGenQTYHYEs8z9LImxDe6hspz+H+W12bduPY8odZTDLQb2+R5OwjL8Md/XJUG+cvbpwv2Wpj5jkjxnOdzH+7VL2qm+zPHZA+Epx8qMUK4PW5O1KcR28Nx58NU8XL9SUgecUOdtwrwf96IGpM1bCYtoP7iY7gWylJgnwcSHHczF1AAmUq7XWLkycPdEN+aIjk1kW99tB/L94WLNq0SR9Mef5MxyqtVekmOBDMGY2Y8TVyKDVuJcRKLqpWBLbJYEI9WgzGicsO+tw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d0d5c2-e20f-4ee0-36c4-08db523b0c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 16:16:16.5318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHkIs6cNuc4gLvEiJf686CpxrBPmB7XTlZsVtQDgouygLmTsCTdwIK9Oj/nhDukgN0XmkopgEQuushxcwjR18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=785 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110141
X-Proofpoint-GUID: 96_Gojd1OeTrV_CyU594s0V-rNbJEm_v
X-Proofpoint-ORIG-GUID: 96_Gojd1OeTrV_CyU594s0V-rNbJEm_v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGksDQoNCkkgc2VlIHRoYXQgd2l0aCBjb21taXQgMDIxYzFmMjRmMDAyICgiUkRNQS9tbHg1OiBT
dXBwb3J0IFNRRDJSVFMgZm9yIG1vZGlmeSBRUCIpLCB0aGUgZHJpdmVyIHN1cHBvcnRzIHRoZSBT
UUQgLT4gUlRTIHRyYW5zaXRpb24uIFdoaWNoIGlzIGdvb2QuDQoNCkJ1dCBJIHNlZSBubyB3YXkg
aG93IHRoZSBkcml2ZXIgY2FuIHRyYW5zaXRpb24gYSBRUCBpbnRvIFNRRCBpbiB0aGUgZmlyc3Qg
cGxhY2UuIElzIHRoZSBSVFMgLT4gU1FEIHRyYW5zaXRpb24gbWlzc2luZz8NCg0KDQpUaHhzLCBI
w6Vrb24NCg0K
