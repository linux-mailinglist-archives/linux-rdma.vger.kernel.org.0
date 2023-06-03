Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A345B721051
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFCOEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Jun 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjFCOEY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Jun 2023 10:04:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE086DA
        for <linux-rdma@vger.kernel.org>; Sat,  3 Jun 2023 07:04:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3533vM8Y021571;
        Sat, 3 Jun 2023 14:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=08pkN379g1vXvnla+tme7VQzx5W4wGcWmfy7+7/fRAk=;
 b=pSVgNTds7qNwfgDeXKRCmMA332Fqs1ZshgXJxUE2kKvSjoG3MtoF+83ciMrflmuOeeBs
 h6N0iac1pLpjKIIwQLez8bk83euLrlPtZYlYVy0IF/hfd3Z2CPBFLwHsYCjAiDlZAIP/
 n3rxCJZxowMzoptt6COyAtiinHQqgzFh/6SWV3SE2IYT5uaUSx7drXlAZ/9Ui6C23H9l
 zo9IJmj4FY3JClnVRXF49+wZZg6AeMPvYl7tw0cpS3q4QILols1XtJ7nm9RWhL2NDTFI
 HQXLk+PmRkkVEFjDVZjpzZ0kpfT47guLm1pGxEmved54+8g4J14K869Li6YZX7OP7ajK QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2c0hyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 14:04:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 353BauYK035167;
        Sat, 3 Jun 2023 14:04:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qyuy7tkvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 14:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx/QGbBraeTuO7no+NU11tom1P/EH0eQrr0U1hr8CxFsH4EWgC6TgKcAYgwApOD7WFTIs94QfCQ2BGRLDx1KCHCEC4407+bahkDFkDlXR5YTcN9Zg1vu51v94hPSZap/BMQE1E3MXOFn0F44/IOCNB0+cV6irTe0+xNW+MloRw0SjvZU0xn4kX9emYvxI+1ADERgcUtA0MTO/h6bF3WZ3bCQGy75YNDH4ISHi9GRI/f98at7yPoKfb+uxcJq0EwFtieTV2R22YD6I4qC229kF8B2Ys+uztOwWaXbLt4P4UUXfQYX+NBQRN9zbJv7SKDyqoXKBTUT+MNz2Qh6N8Fx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08pkN379g1vXvnla+tme7VQzx5W4wGcWmfy7+7/fRAk=;
 b=XY1p+ECFYowouYLf3PbF/DOcj0q8G9ttOmrESI+LOv6805LpxsTGIZLf+c2f7FDxA0EIxhjA8oHcT2MY4U7fcqBsDa1OyewNlOMJhbBlNKbJmmIKVeQVPdrzRsJ7YSF68DC0b96AxQgkpYogtECOWWsKqdCRq7lfS5NNVMAZV3sfmA5UOvVbQQxe0nfqr5DF/g1qcRkHTE5IbkGR5UG27nuHGXBeJqTaR387a4IZEcCyXr1VaBNpgJ8LYZ8nbq03eX3AXpylcNpwxBWUq75nmRhY/4Z//iLwrb7iLf3peQ5kEuzHAHcONNmS1cUKzdxD1G3Dg6LfetV813Q9V/uwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08pkN379g1vXvnla+tme7VQzx5W4wGcWmfy7+7/fRAk=;
 b=AAVRLbreOr5l9cf+HlmTqcOpqVvbuwySk7fNeSwpvJXDtYLE9hhg82NvlMLzmtaGVnFNZF/YrhUSIi8CKJDW3mKwhWiCfHamNzqlOvOwkjI0LQGKqxwUdLBsw0WpF/y1voJR6IJb4MuJxt2SdL232Jz3WDdgCqeq4m4qMawsB/Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6859.namprd10.prod.outlook.com (2603:10b6:610:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Sat, 3 Jun
 2023 14:04:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Sat, 3 Jun 2023
 14:04:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Chuck Lever <cel@kernel.org>, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback devices
Thread-Topic: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback
 devices
Thread-Index: AQHZliMZ/D0shCgk30W/e0M9Bx9eha95G54AgAAAlYA=
Date:   Sat, 3 Jun 2023 14:04:08 +0000
Message-ID: <D9A02961-BE4A-4B71-8FB5-6A0662853BBB@oracle.com>
References: <168580052064.6320.4273961644261511156.stgit@oracle-102.nfsv4bat.org>
 <SA0PR15MB39194A46F4CAD3322221CE19994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB39194A46F4CAD3322221CE19994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6859:EE_
x-ms-office365-filtering-correlation-id: 2d830d8d-ed34-4cc3-65dd-08db643b6651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3K5i6ZVE9EZgYcL1SbjAA25bFJdjb/mJNxHp7CY2BCE0FMwbZ2hmQWHjw8RUksZIgcv4Ibi2dZSya/NiT+Hk8v4sVcg62/slzl1fxJvsnA4u2IV4sM+uzYN3J0Uly4trQkbg3Z6JandrW5BcY7VaCTrR+ingwZGXGBwkdfehcuisXoBdjJ8W1MntBssbR8GLT+tfgOmtciYrWm7q1B6zOepr2EntxApWl3zxCexQ1ED/kKLfuBbk4Dcu9hl48NGk6/dj42XLqqVTSQEdpuNkRF0e2+8iSwAy/+1EZa9piflPljHH1kfTcAPQm8hBgUVppO1ZEAuqie8Y0RqvezZx2ZemlrTbgbxGO62zfUohn3TkKGGpiEU52ojZYQh5/5oRs9f92ZeT3eN+RDdEogwSLF7uOdhiMx+CiHQAkAwGXOObYdhLzzrWApAdE60uNc+0592gRTN6dkgUVDxDHwkt4HL+1LeKcUNA0LOZSpE0QqcKO7ZF+wgiOvIFkQUDBqDN0O38ik9O1iYtW7GiwviRXwKStxq9/N9YBw7SHYLhb6oLc1brZCjZFNNyLeRUTHJGLzZgnIbUf7pNWfJLvFCU6cHUkq/8XlVMw+535EMLtBFCMrt0pWfrTWXFef7tF8gUPRVScvLZpAxlotk632IF7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(86362001)(38070700005)(38100700002)(122000001)(8676002)(33656002)(36756003)(6916009)(66446008)(4326008)(76116006)(66946007)(66556008)(91956017)(64756008)(66476007)(6486002)(316002)(478600001)(54906003)(26005)(53546011)(6506007)(6512007)(186003)(2906002)(5660300002)(8936002)(83380400001)(71200400001)(2616005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xAJ+TsLHnq881pjYgvabbralaolmFSQxAAMY9Im6C/gr6YD3pDWHmjtnMjXo?=
 =?us-ascii?Q?lB38N7slJYG8oENiqorby1O3oYZQ+p6EEBi9n0M3R/n8Am/3ln14OFvcU1f1?=
 =?us-ascii?Q?f6SPdiE8mb6wVFW/gaKePHYTIdXzTf9iRlVH9UESn0Y7yBDm7CeNGwOfDTin?=
 =?us-ascii?Q?Ii7iHPjSOLWxuzjlkC1d9Gi56pFZbWr1VHugDfcMCEhfqNgwmwJjo6esFWlT?=
 =?us-ascii?Q?t7V99MnEk8o5HMIPJoltNcEY72RT5wDMW+bzMOVPeRS5Ta2jfssnz2I0Alk+?=
 =?us-ascii?Q?sJkYoDn3rbBKaOSmGsf56yXaik1itQJYrPoS/rpEPNdar6Roq7EsyRVYrCV9?=
 =?us-ascii?Q?qejnFOsFf0Zq+P0UlqlP0oh4deXTN67ZvpLwEDs8u2IYYveCR0sKlOb7gcyn?=
 =?us-ascii?Q?HiUn8ZWV19Xof5PNh5P4TrJWzXhzsZM+WddPE86EW/CZDPwOFQwkb6xBOep0?=
 =?us-ascii?Q?IFqt/sisxGXYQQm3J7IrfF8eThnF8fDL+tUckp/EL+QXQIriGO9ypzJoq2en?=
 =?us-ascii?Q?X5AJbWSCHihvRmR3sa6G2JzGPOd07NuUgEvZkXtVaLe26Z2DKGN3Ry/seOAn?=
 =?us-ascii?Q?TCKAYkIxltKmPUfHmB8bfnctw+1rKK4tMe2Zvc1k7fHVB/jqGGpeyU8ckC3L?=
 =?us-ascii?Q?fjFMKejqpWlOjdXeE74uyaShPWWirpOcnpTy3txIreQCh2TxBJqXoVPFk2gR?=
 =?us-ascii?Q?J5c/KmtRsDI7gckxLi9Kr5DV0mHbuxVyaomcl849wfqy9bMGS7TXVkLt2kJ7?=
 =?us-ascii?Q?mptTgDvGew4sg57DGw4PK/zGnFF84ffYtKqqwpz5Ej0/UT82o/ZGu/S1HUAD?=
 =?us-ascii?Q?h/5YcX9V487kvlvfuJydwFiUwFG0kncowIOFElAvBdsz2Bdwcb1PvdzQQfI7?=
 =?us-ascii?Q?7lI1K/BLd3liLMh09UyjQdBJ2XTTMStPa6140T+WU+RZ91rnPvMiUrip4cjj?=
 =?us-ascii?Q?YCVyHy5oqnqQtz42xrlKtvOmDY4ad2dsNQpaCW2FJvOusyz1XLcnzlJZQsQ5?=
 =?us-ascii?Q?Ez7/u7+qYroMUAceEDUGdwW0fiPHaKVmbNmQ33eslutozPpOXx6JWkcnWudN?=
 =?us-ascii?Q?cGgjsa3MdWjvw/MdnS8aHsjhw+i/ohQ/Y90I6iISKmDUvxRmMlrpq/9AMtcf?=
 =?us-ascii?Q?AMRA+3K3bFk1fEAVlSudWwm9CT/jjv5qLPZ1zn86E7I93x0n2GtB+hfOLnyI?=
 =?us-ascii?Q?ywMKbsuMwLPAbxIrEOOsENp7HGFxbplGQp9Cpewpdu1WaDeobYUbo6RZRY96?=
 =?us-ascii?Q?a9rgTrBccbwQ1GyJCBOgQjGwWuOY3yGQkPHayqoxW3HmLb8pbHvovGs9IKh1?=
 =?us-ascii?Q?Vn8xO1N8AXcbDHX5dUCdE2S7p3ixyDPU1CiUVJZ/fDhrf1c737GxT1clWlPg?=
 =?us-ascii?Q?QyTVVvrRict+Yl42HWv4P0DOgz8WC2BVZB23DruYjmABrWhpkkvKmko2pSVY?=
 =?us-ascii?Q?2/2maRfXHD4O1j0pyxsbFLDR4MDOEIDdqxfl4NPgcPUAM4uABZwapDWBcKKy?=
 =?us-ascii?Q?YBbz4uIXGq3pnuRyWu0GdaJ6Yy+VC/6uu08sYCizr7CSxdvudVIGV6aTT1gh?=
 =?us-ascii?Q?7F6Y5Mh87tCR5fMa6qU2sQ4JK4SeJbCmvADbfuvZUzLkk29VGpvylsdr6hsD?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA4753EFDCBA044C8684C21B6BCABD21@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h+f2gg9Vxb3RyqR0w8hNeBmVBJBG0/yocNVSF4BArpzE0i+LREVmg14vv1J+Xcld21E0GlK1t+D0CisyO6YfMxY7qmgnOVAZCzn2L1Vx2D3MAJnf2yz5Wpwchvgj8mm1O1mgfw3XpltrstYYkEv0aSPH+XP3lPm6dqSv02fwtWshQAuZ+rFLZla2gihygKJCRLSp9DHnv8hMF9++a5ngASFl8fBG4PDoVgLxojbTLdnxKTYq9S7J5m3NjHVf8tQEfr2U20gtkx7MRZRrQ+LXvRpTkuLIYCpFIWw4HPYx2IDyVSZdfeOIXurmLCXRZ+cntnONRxS7kS/fLOxWxduzU7qnvDTa5jlGfd02D3C3hcrdENr8kzL8g5IHR3w9zUaBHpkjEfTYcNW1JcfOH+T+O4jTaqLJhs5Ilj3M1SqYaQD6kQkwqq7o4chk74oj7IsufmBmcW6bK7k5j883oDNo7yfrhOb1hVl4SSVaKLlL5GNeszxwJNJrxPcRNfauA0xrJMCLc20cVNLaAs51I18/FUrHxcuG5RNNBqDamM3hqq7y0OWwyNqe1uHF77MU0epaZnpajeREh4pUFjHJ+7OeRmzwiGXHeT1sGE3aM2FWApSaopR8agbBergQo8vGnUIEHffAZyT2qDGOkKnHOHKtaCZZ1/iO/31F+mv+ROsTo9VaTRI4GuCkBX272QPqNLQ+C1I4n1k3XM5CphJQKry2TVYxhBDghq0NSNi+8AN6yBap8AUuNLP494/xMl2IDVVXiogpMFdVtrwqqkbZ8D5zDLLiyeyQFq8TQIKng0B6lwoAp67SjJ7569L4UzyATkXlssOzV3HeRRiAXA7snFNn1hl170CcBcZw12rkkGjRSaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d830d8d-ed34-4cc3-65dd-08db643b6651
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2023 14:04:08.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEJN8299n0ISE2cNLIa02CAxVueR721cmqFeLltkE2gHvtblwNNgxRgB3U/SsXMMNE3MQ8uQYFofvXt82ifvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306030128
X-Proofpoint-ORIG-GUID: kI29cBF9FwMv31pmowsj72mZx1xIVStY
X-Proofpoint-GUID: kI29cBF9FwMv31pmowsj72mZx1xIVStY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 3, 2023, at 10:01 AM, Bernard Metzler <BMT@zurich.ibm.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Chuck Lever <cel@kernel.org>
>> Sent: Saturday, 3 June 2023 15:56
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: Tom Talpey <tom@talpey.com>; Chuck Lever <chuck.lever@oracle.com>;
>> linux-rdma@vger.kernel.org; tom@talpey.com
>> Subject: [EXTERNAL] [PATCH RFC] RDMA/siw: Fabricate a GID on tun and
>> loopback devices
>>=20
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> LOOPBACK and NONE (tunnel) devices have all-zero MAC addresses.
>> Currently, siw_device_create() falls back to copying the IB device's
>> name in those cases, because an all-zero MAC address breaks the RDMA
>> core address resolution mechanism.
>>=20
>> However, at the point when siw_device_create() constructs a GID, the
>> ib_device::name field is uninitialized, leaving the MAC address to
>> remain in an all-zero state.
>>=20
>> Fabricate a random artificial GID for such devices, and ensure that
>> artificial GID is returned for all device query operations.
>>=20
>> Reported-by: Tom Talpey <tom@talpey.com>
>> Fixes: a2d36b02c15d ("RDMA/siw: Enable siw on tunnel devices")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/sw/siw/siw.h       |    1 +
>> drivers/infiniband/sw/siw/siw_main.c  |   26 +++++++++++---------------
>> drivers/infiniband/sw/siw/siw_verbs.c |    4 ++--
>> 3 files changed, 14 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/sw/siw/siw.h
>> b/drivers/infiniband/sw/siw/siw.h
>> index d7f5b2a8669d..41fb8976abc6 100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -74,6 +74,7 @@ struct siw_device {
>>=20
>> u32 vendor_part_id;
>> int numa_node;
>> + char raw_gid[ETH_ALEN];
>>=20
>> /* physical port state (only one port per device) */
>> enum ib_port_state state;
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>> b/drivers/infiniband/sw/siw/siw_main.c
>> index 1225ca613f50..efc86565ac5d 100644
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -75,8 +75,7 @@ static int siw_device_register(struct siw_device *sdev=
,
>> const char *name)
>> return rv;
>> }
>>=20
>> - siw_dbg(base_dev, "HWaddr=3D%pM\n", sdev->netdev->dev_addr);
>> -
>> + siw_dbg(base_dev, "HWaddr=3D%pM\n", sdev->raw_gid);
>> return 0;
>> }
>>=20
>> @@ -314,24 +313,21 @@ static struct siw_device *siw_device_create(struct
>> net_device *netdev)
>> return NULL;
>>=20
>> base_dev =3D &sdev->base_dev;
>> -
>> sdev->netdev =3D netdev;
>>=20
>> - if (netdev->type !=3D ARPHRD_LOOPBACK && netdev->type !=3D ARPHRD_NONE=
) {
>> - addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
>> -    netdev->dev_addr);
>> - } else {
>> + switch (netdev->type) {
>> + case ARPHRD_LOOPBACK:
>> + case ARPHRD_NONE:

One thing I'm wondering is if there are other cases where
there is no L2 address besides ARPHRD_NONE and LOOPBACK.
Should we instead check netdev's addrlen instead of checking
the ARP type?


>> /*
>> - * This device does not have a HW address,
>> - * but connection mangagement lib expects gid !=3D 0
>> + * This device does not have a HW address, but
>> + * connection mangagement requires a unique gid.
>> */
>> - size_t len =3D min_t(size_t, strlen(base_dev->name), 6);
>> - char addr[6] =3D { };
>> -
>> - memcpy(addr, base_dev->name, len);
>> - addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
>> -    addr);
>> + eth_random_addr(sdev->raw_gid);
>> + break;
>> + default:
>> + memcpy(sdev->raw_gid, netdev->dev_addr, ETH_ALEN);
>> }
>> + addrconf_addr_eui48((u8 *)&base_dev->node_guid, sdev->raw_gid);
>>=20
>> base_dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
>>=20
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 398ec13db624..32b0befd25e2 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -157,7 +157,7 @@ int siw_query_device(struct ib_device *base_dev, str=
uct
>> ib_device_attr *attr,
>> attr->vendor_part_id =3D sdev->vendor_part_id;
>>=20
>> addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
>> -    sdev->netdev->dev_addr);
>> +    sdev->raw_gid);
>>=20
>> return 0;
>> }
>> @@ -218,7 +218,7 @@ int siw_query_gid(struct ib_device *base_dev, u32 po=
rt,
>> int idx,
>>=20
>> /* subnet_prefix =3D=3D interface_id =3D=3D 0; */
>> memset(gid, 0, sizeof(*gid));
>> - memcpy(&gid->raw[0], sdev->netdev->dev_addr, 6);
>> + memcpy(gid->raw, sdev->raw_gid, ETH_ALEN);
>>=20
>> return 0;
>> }
>>=20
> That looks good to me, thanks!


--
Chuck Lever


