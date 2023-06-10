Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2972ADA1
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjFJRL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 13:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFJRL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 13:11:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B323589
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 10:11:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ADMSDP016573;
        Sat, 10 Jun 2023 17:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Byh9B6cKLY1fJ7NKCfjxfeDAFc8Cdw43qnrJA9rSSrY=;
 b=yhzIRHn09CGtOrrzcUEnOn81IwECiDs93kSJ2572qsmeSewTu/xVfOCaR/sywVrir8jy
 vKG7Dl9zv0OGrbleUr34bA9MToUc4pzbMPi8qv7YqiHfy52Z2liURyCPgowwIWilGyOQ
 V2mnb98poD0Fzm+tpbdRBJCIvoCPclZ8L0logEAThWbzDCuwempwA2l6Ld8qTrCurbSa
 Fk5TE6H/HvQbmuOA616GeDPAFZbhx/0xjFSsax9QfD6GtzlvIAJYDafmSmvEC6jlnSnr
 8dJcbFB4GHqqvg1mC2ej2dVkzZrIyEJ3nnowC8mOLwtdsow1vauR7T07FJYHcTcpcilJ pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstrky4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 17:11:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35AFT4G1017793;
        Sat, 10 Jun 2023 17:11:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm15n2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 17:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYrNu8S4KFTpPHvdUv5YcmVU1CK2Xguk/yk+16Xq4CQiq6KsmNBxJRkrhUUUb8HufgpYwosV9x9KzMYbi1aMlyaa2tvk7h1fLFvuafgiLt4ZZc2tK70fby6ocLpURtaoyY7cJvbG7oT3VPpyWPpqVxaK5vbEaUtEyr04W/KQgky/X6Ao767f2zCRR7O/NgkgXFjT9e0Dpb2gLFoGwr1C6V++0wUoJ4UF71wpImSDejaUPLratFs2dnTnKh9PpgxffzTMGS0oSyj7ObKX0+QpJa+1HVmCedlMiJGf3b+1Dxog3/MabwLZWDdwZMScxUwTrrOlCrmZ/iye4xYTdFuKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Byh9B6cKLY1fJ7NKCfjxfeDAFc8Cdw43qnrJA9rSSrY=;
 b=dWi7F+gVVhK39lyHifF2d5MQ4/5J1jXH7u9C3cYQAC6r8YCIXw2Bzk1xzkopSce/Xrmoooj17L0BpUyLltCZCEOyDUWomdSZ1lbsARkN0A34SQe7UcXsXjwKONeEUrCGWKawliFbwkrohOBcine2udLJuczI99PCqSXtrUtIspfCOENlWXnGicPMVvJMA0O683OHFVXl5QbExPul5fALC13K2N9rziulaGaxBEBzMB9D1Sy8WYbVGcYDOobXrDSfzbTUKLhaUetZmHPIJ0+sU8LpUb/Tjlf56KNQexGXyPxxTxgKUnbuhBT6iAp4rWvvUttKIawXc5pqQ4z7Opdvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Byh9B6cKLY1fJ7NKCfjxfeDAFc8Cdw43qnrJA9rSSrY=;
 b=WO9c8iW5Eep+FIpG0nvgs+1+0gYAOfmj/KR06exdMT/QkClijeqr9NjZ2koR7quK+bG7rIs1s45ZKO/9O29G87/YIEmF8mU5pwUEGumreLFKUnUHvx17RlncHQA5brxl2CEKt8g4eML+JEX5s5yf6Ri/hZk3FvUxESrnNGjlWp4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6145.namprd10.prod.outlook.com (2603:10b6:208:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sat, 10 Jun
 2023 17:11:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 17:11:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Chuck Lever <cel@kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Topic: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Index: AQHZmXhvzGSl24EZQkuCbGf5eLkl0a+C9OuAgAD/vwCAAEx6gIAACP2A
Date:   Sat, 10 Jun 2023 17:11:13 +0000
Message-ID: <E2B769AE-41E4-4C4A-95AB-6CF6F90A0541@oracle.com>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <ZIRm9s9xjq3ioKtQ@nvidia.com>
 <b7e3081d-51b2-b74e-5e22-cfcab88dcc51@talpey.com>
In-Reply-To: <b7e3081d-51b2-b74e-5e22-cfcab88dcc51@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6145:EE_
x-ms-office365-filtering-correlation-id: 59a13fb8-72fc-46aa-85ba-08db69d5b1c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DzuM/p/RnpS9/Pc2JP7Dv7lqG2W+ce19sxm0ofkEE9ktzIgS0z5Y6i6j2RdxxyRtd/Z9thH5G9QZEPigpIa5tpmD2SXAR/VX2N3F1AYB1G3bRCv6lyRm4inHQQUq6Hff8Iq6HRlrHbqZ7+V5Hnrq3Nz+HxsngPyzC4zwadjjH2Ofsn82R2gQL0gdSmhHkIfu9ntOVTyACHreyY2DbFmd05rBZgAlRc68XOjMZbCQjBAtpeC7XvDgHTl5txwdJQYGv+e/GaEAqSm57lVbJVby3bN0pgEzKlPvNtd2e5A7f1JBhtMNiTDXeOv0q9k1L3gxfi550575T5OY/sReX3TqijvygE2jt+T8qLznf8dRGOBnGQJINgo9qsd2NW7sH6ht/YbZD4co03SXIwYlcRbKkhVu/RxnVVNfZQyvYkO5kx7fW2zdBqnJUoAU2DHJktTnfus+lZtChaC1bxzco8H05ODizSdt8FqGk4e7o3iT8ffIyfC6zUURGnblpN88k3XKauV/ScZHo/oyxCGaR7q4PIPgdXWTpT521eWi6ozxb2nzpdl0m4ZLy5dGZZ7wQLelSVibde2YzT83ZavZLP8vGqFyDKhtge1F4PKeeHft5w9BsI2h1e/90XzFifrA+bc0CLlYMakt7D5MxPzcCCTMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(33656002)(83380400001)(2906002)(2616005)(186003)(36756003)(38070700005)(86362001)(38100700002)(122000001)(6486002)(316002)(5660300002)(41300700001)(8676002)(478600001)(54906003)(8936002)(71200400001)(66946007)(66476007)(6506007)(6916009)(4326008)(66446008)(6512007)(53546011)(66899021)(64756008)(26005)(91956017)(76116006)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P/mNwy78wIz/pYReRP2XJbjL2612v6M13VHw9qLPHAYvgFC7wPuFjEQHf0ea?=
 =?us-ascii?Q?E+BBraLZrk8nrG3M/x8iOMMyoM7kJe+vuKU+2e48prFYUVCJ8+HFrRfrB4iZ?=
 =?us-ascii?Q?mPLIJFnV93Z2Lg3IHoMVcgPUjnuD5uEgA/7U1PkjQH7Bt06/5TklBULkZ9Du?=
 =?us-ascii?Q?ZJrtGx37r7ZRnRH918YUMYGK9XZJs7Xeq+WkIX0/lOP54Xzce4wYDQwn0KMc?=
 =?us-ascii?Q?YoJWMCkuzmq4Fh3lrQeCBrPr5oLH6rdMRLsryKLcKqAwTssssjGiT2lpRIHo?=
 =?us-ascii?Q?Z7xHILhBjqTmGzB8r9j7k0dVHooReuI0Hy4qvU6b7aSVa76aHqnsIbDXzTSY?=
 =?us-ascii?Q?NXD3p6l/RI+XDoh/a3mc1X1BRFZ9aCkG1IoHAywvkoLQ+WaM3cGK8L1dwqKQ?=
 =?us-ascii?Q?upfvI46yVJcZYQ0JBiQ9PLzbVo3g+q9zTOz8i1RsYzj/tcUt4jTYfneWPIUi?=
 =?us-ascii?Q?Oxiv0d9siTwPa54DIY0uadwwBqb5Z76qEOSJiMYBVn8xwsUXgSZM1nOess/q?=
 =?us-ascii?Q?pGQykgkRssNT/gVgjIxtEomrHVEWCJ4s0me5rRv42NYL/8HS1bnnS+0SQm34?=
 =?us-ascii?Q?XtXseql/EuapO1N1CK12U8MdzsJBZBUPtVR0ZG+/bN9ogKFOuUPwKSPF0iV7?=
 =?us-ascii?Q?VXvQ7VnPbjL+JLa81mNXlAc/mZew5J/Dpow15Hwm8UTJKXpPns8If2QMYywD?=
 =?us-ascii?Q?zLHf6oNcqn6YrGeKSC4FrL5Pme+lPfQ1VXlX4AKO+VtGHCtiglF/JA1gUVWh?=
 =?us-ascii?Q?T30r9HjGihuD6HM+dszTW7PnE4qDxgcbRMDya+s51Q0Vi+6/f/Hr4a0hKbzS?=
 =?us-ascii?Q?J/A19odzpgJkzVM181a+wpuujF9aUUUgihh2x+kGTWZ11UntS2C8J8r8+Phy?=
 =?us-ascii?Q?GqOohpmbakhFydw684b21qJ+aQv+mLiofchTEiMpQFSGLOi/dL2AW2ubt/rr?=
 =?us-ascii?Q?YDbgk3aP7nRbR23a2UH6+ZCJVVY1Bqm0OXSDowqQzt15Xjah9wMTHJ2plhoD?=
 =?us-ascii?Q?aQmLVRQiewdNFP9Zu692DyPxo3zkFAT3u+326u+N8r/8xYYMZgv6+lnpJDJw?=
 =?us-ascii?Q?0KQRwB74Dsz4VgEzdrzj/t36KQ1Fvj1FNvFjWUjJrBhBcCV4vlvUETVm2vhV?=
 =?us-ascii?Q?w+3aLYXXFyZkSe9vxgnNsVgvLCp56SGZF+9qdvxXchT2/VJB81Ql3PrTQZrF?=
 =?us-ascii?Q?/Szag9Xyl6lC+x76Qsn9BshesicYgk5imi958T+2p8AFEuoJN79egY0RBH1E?=
 =?us-ascii?Q?YtggCFm2P4sImhYFkDxW8hyto8BGvJeRPRGNU9RLjcyKzTS7f5mkl24QY5aa?=
 =?us-ascii?Q?X5lZYL84M9Z2dLoQbYaphExo7epWxGK8TbvXsrO0YGs8u1ekgJBolazAc+RU?=
 =?us-ascii?Q?hm4AGoYHEEQJDvFHRzGc2iZvYlEyQfnMKIqv2voH+Clo9QDstprDDQ+4dBYi?=
 =?us-ascii?Q?JGUVuJOtSTnzsY9haEwwjjKnpnQABK+EyzKrkS00SpxeRXMXbYL8o8B3pmV6?=
 =?us-ascii?Q?6FdjszIVUM9xR4UFjfLoyF6SSUO3BlUfzGjwluFyZTb8NM+o6Ox/5J5CyxDD?=
 =?us-ascii?Q?audqFUE2/JD4X/4gwun6TFYPTpZtjmhmfbyvnlNyuujh8i3Dkr2xraxbFvff?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4013A702410F30419E5695456F62DA26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MrOL/SKVOIe8U5ZVMlb3HcoCmqNkVeamz6sAc7ApwlZKD+D8Y6wWpDJVSRGLQWdiU5Nrjfkd6VEkOO0etI9C70hMIepL9ZEPUvwcMUdvVEz3J9qmvcRKSE9pGjGmhbDiXGvCRdtv84p7SwYZMNr/T+N+KVkLKv8S6USuC5lzsYU1yBvF7XUDO0TBv2XCtxh0zQh17TmWaciW/08oWjO5YpVgZ/gwFsALgJOsEDfZeJ0NlER9yasROuKhGZmHMtJHJ29jWv9rlz2WmM9/94hXIfDABe++8E4rh+jOpg1TZboNuvVniRhy1VX+bT30eCEe5BkkveAEKyT7Nz39LKKCi1Cu0qGfUbDlGS5JekvfZqjacslrUAEhKWhLVwVDU2AV7pawuaCP/ByHEuYr1Cn3VD1LCHY4TuwB08LflzwjfiSNAPFxqxikzLFmLVNRBg/UBv6EuklX/TwIzJYuJwQ2SXKZrFpNvNwsRV7zXavpo8xKjqUULtPiJq3rCdVq4AeTWE/pRdcF1EjpSAQrLn92/WPmSf/UqJ0yilzRq0QgOzl98zXYdY4rv9E2L1lgOFmB+oZoOnOq4KoiRtYNGKQJkO1v7z5RTgprsBChL+oknCiB88R7BMDKh93LwhyLDt8rqDxGbwA+dN4IdatV/LZxxww8vrVyrAfq16FV+Io5yq3TnJAgo8BuTnhA3PJYuRMpFvxn2MBYySFkX85En18Jwv+fS8UebkILW+SlELK2eiZmrxiDM9FTn5d4VzWzZ3KAACkqEkVVzSGKi3n7XyFjQ3v5tpQw5nA3OC/YYXMZmQQZEmIDB7OqM4Az3F/6xQBGujKx42g1z81SS7ieHcmJUU2UTnpp0pgSXJ8DjKF2ZDtDZutd6ioWaWtY27YYBb6ePQAd3jAGzvZaVgKqWexrDQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a13fb8-72fc-46aa-85ba-08db69d5b1c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 17:11:13.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IRKSHUdaT987G1w1d3OsJzvpFoXeyARjelLnA5YvB5AnoVyCDP3dSXaO6yIvj+7Zr6d0T/NrDwVa8oOd6Ht2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-10_12,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306100149
X-Proofpoint-GUID: b6FkpPaQOACOJfpL9m11zpCTnvC2kp5_
X-Proofpoint-ORIG-GUID: b6FkpPaQOACOJfpL9m11zpCTnvC2kp5_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 10, 2023, at 12:38 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/10/2023 8:05 AM, Jason Gunthorpe wrote:
>> On Fri, Jun 09, 2023 at 04:49:49PM -0400, Tom Talpey wrote:
>>> On 6/7/2023 3:43 PM, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> We would like to enable the use of siw on top of a VPN that is
>>>> constructed and managed via a tun device. That hasn't worked up
>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>> no GID for the RDMA/core to look up.
>>>>=20
>>>> But it turns out that the egress device has already been picked for
>>>> us. addr_handler() just has to do the right thing with it.
>>>>=20
>>>> Tested with siw and qedr, both initiator and target.
>>>>=20
>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>   drivers/infiniband/core/cma.c |    3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>=20
>>>> This of course needs broader testing, but it seems to work, and it's
>>>> a little nicer than "if (dev_type =3D=3D ARPHRD_NONE)".
>>>>=20
>>>> One thing I discovered is that the NFS/RDMA server implementation
>>>> does not deal at all with more than one RDMA device on the system.
>>>> I will address that with an ib_client; SunRPC patches forthcoming.
>>>>=20
>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/c=
ma.c
>>>> index 56e568fcd32b..c9a2bdb49e3c 100644
>>>> --- a/drivers/infiniband/core/cma.c
>>>> +++ b/drivers/infiniband/core/cma.c
>>>> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 po=
rt,
>>>>    if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.=
net))
>>>>    return ERR_PTR(-ENODEV);
>>>> + if (rdma_protocol_iwarp(device, port))
>>>> + return rdma_get_gid_attr(device, port, 0);
>>>=20
>>> This might work, but I'm skeptical of the conditional. There's nothing
>>> special about iWARP that says a GID should come from the outgoing devic=
e
>>> mac. And, other protocols without IB GID addressing won't benefit.
>> The GID represents the source address, so it better come from the
>> outgoing device or something is really wrong.
>> iWARP gets a conditional because iwarp always has a single GID, other
>> devices do not work that way.
>=20
> Not sure I follow. TCP is routable so it can use multiple egress ports.
> That same routing means an incoming packet bearing an appropriate local
> address will be accepted on any port.

An siw virtual device, for example, is paired with one particular network
i/f. I'm not sure that "multiple egress ports" is applicable. I would
think this is also the case with a device-offloaded iWARP implementation:
the egress device is always the i/f on the offload card.


> So still, I don't think this an iWARP property per se.

Agreed, it's not particular to the iWARP protocol. But it does seem to
be particular to the entire class of iWARP protocol implementations on
Linux.

Adding a comment about this distinction would certainly be apropos.


> It's coming from
> the transport and its addressing. I'd hope that this can be gleaned from
> something other than "it's iWARP, cma needs to do ...".

I could add another flag somewhere to indicate this property of a
device. I expect only Linux iWARP devices would set it, though, so
would it really add much value?

Do you have a recommendation for where to home such a flag? Would it
be a fixed device property, or something that would be set dynamically
during earlier steps of address resolution? Again, it feels like
something that would be set iff rdma_protocol_iwarp() is true...

--
Chuck Lever


