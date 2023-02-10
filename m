Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2269179F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Feb 2023 05:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBJEo0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Feb 2023 23:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBJEoZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Feb 2023 23:44:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EE35AB17
        for <linux-rdma@vger.kernel.org>; Thu,  9 Feb 2023 20:44:23 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319N4Q5j024009;
        Fri, 10 Feb 2023 04:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RFmW+zs09JArNLoudi6eTp2El9HELuOb4uCiqEcF4Uw=;
 b=LG4fkCv99w3PJxfpFWQlDSUcRhdFISbbNAaKOqUAjVAS/A33fnRWstPt6efQRWTuBTw2
 WWsMvmyKPyg637e56Nj6W9suQsecbws483n0A3tP2R+SYFG6tNviapTF4oe7kDQMk8Hy
 Ans38rLajYAi296YMmEdXwZdIog+tbUKLvMRXpnK7ymMA4vcgoM5Qyo+v5+ErjgJicBp
 tvju/PY/Qjyp3/NiF6u4rc/tHf7nYXqapebp56agFa/BVmYk4vwqhJnfMf9ref9eY8/X
 9RwOdlEo7oByJzFF4cJ+7V351k/0I5OZlPs4XJGinoDhhRSX1e0DnSD4aqJHD3m+3Gd4 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwucckf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 04:44:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31A3BHBB015270;
        Fri, 10 Feb 2023 04:44:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbeag3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 04:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3/nOQcDSCrOEINrz18ZSjZi6AMUU3nu/wj8G52ySKEI+Eq0GtX3767ZzluyaFqaBEuTJ6S6FkK8mu0yofxX35rlkEsfilhtheSBJIfJVyrT7uZP1dVmeL3sWtg4rzrnCIkIPab/O9Vpw7K1kk3I6+sbCdYeEk154vs4Wr3JdnMBCyTRi1DdKsg7ExDmmsSyewCMcd4DjynwoNkOIaX5RKzgj0dulllgQlGI5FPaOucfNeIwFfFEZV7op2BcwwO5sLo+z07O/DeujH2iogQedv7XZwhaLKEvWipGammuUejnqECShwdF4kxUidgb+HUvwP6eti7ZOzZaZGyUqEcSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFmW+zs09JArNLoudi6eTp2El9HELuOb4uCiqEcF4Uw=;
 b=YtlZaYnoRDF8k7KfVh5nJjH9Ek48gKmAt920KkFYwkGEymlFTTvD3WRoltga8Ln5u2R2R63uxKkm4OJHAIhymVnnkeEb/4jYI0koLQ6gjW2VGgwa3DTSwmfQipkpO1mekqV4KE9PI7/xp7gmdX4rBYiBQo305vR5EuHCHA6BcL5NOVizmO2nvtarC1puXUyUPlRhaJRoGnpq6hevZjNKTxy5ep8oBFRspICVvGA33KWq5bUmjTyuEo+9HPSQC0N96Lo31XRPUS4ulheQ9FwsKH37weKI06iRZW8KmYsyNuwe95fX0Ks9W9gQi59SzW0NN626TqMZGCu44parHwhtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFmW+zs09JArNLoudi6eTp2El9HELuOb4uCiqEcF4Uw=;
 b=wo8iA4g711ucrHryWkE/+Xe1+L99PXoKbW+WCy1xN++eY6FcBN4n+APYnBGgQbczhXhIaXyzePfD1pAkXF49df1Oq4nVJ1IKglZplPHZxGoWdKwrymXsTCnBwI6vpO52TTFbjJrLmGedCI9XbasOYxvmqgZ+dyja1NFavIrdQdo=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by IA0PR10MB7182.namprd10.prod.outlook.com (2603:10b6:208:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 04:44:09 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4%8]) with mapi id 15.20.6064.017; Fri, 10 Feb 2023
 04:44:09 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Davidlohr Bueso <dbueso@suse.de>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] RDMA/umem: Remove unused 'work' member from struct
 ib_umem
Thread-Topic: [PATCH] RDMA/umem: Remove unused 'work' member from struct
 ib_umem
Thread-Index: AQHZPKbRz+9QDfeEI0+p/8Yr1xNf867Hmypw
Date:   Fri, 10 Feb 2023 04:44:09 +0000
Message-ID: <CO6PR10MB5635E58A4C8F5929EE913FB7DDDE9@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <0-v1-22a2667fa089+a3-umem_work_jgg@nvidia.com>
In-Reply-To: <0-v1-22a2667fa089+a3-umem_work_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5635:EE_|IA0PR10MB7182:EE_
x-ms-office365-filtering-correlation-id: 500e48fd-e10e-41b7-6621-08db0b2172c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0eowtwW4MzpWFcFMpr1n+uOhY+Lf/wRN96Oz1rDlXvJ2N9YPQ55TcSZdIBi3uKSK+va7USnqHjIxPx8XI7Lvjv4wORsuu3GZk8XQZfizZX7DXYtx2gRYIxg1qhPc6PpX/B6DuApQb1eYVW5j769VvspwzsiMBtV6b/RbnO+ToSrHYVSnoj26hc92asfDnGZfOAcPcdVnBi3oXffmOlePIno7lbzBt/Mo4dhw/G4T++0XPJ+52cMO3E4J1TkguaUBo4y52xrHoVzTTGDZ8C/VbFeXIHjji3A/bt+WsQI0PWgZOLkUkZmEyNX6UYoGfe+oLNYYtzotyFNySrVAvuFONel5ZGTxrrLw6mjBsEzpnLJnsj+N9SdwQdVmxsqcp7AFDTKfMCLfOVyWUAZin76vQ/hX71Y8JQaDFrRb2FhfGxK0zYARo2l8ctAZlfi813YIi3GfLvA1OwP7sXBynWivxnevehENHH2CpVRDMFJDSOFd9RKlzjy6EyZ4ujYqbUPfvgi6PaXyuRGLsqatX6wzZdMkqkdCI7DwsMyrd05267P5R0Ym0acuRMzDsD2S69KyHpQu56mJrrnm0QD53MHB5CGgWhWWXEYHq/SBp/diMXBiFeKrnXkfYDqPP0necKIZcQeyJBmmVXGjtnGHO2IPsYbCZ4WsmJUO7vUBaqTRahJNZS+un9FAQZvN/ia+PLyGUIzY4bxcBe5BeOECq26Vug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199018)(4744005)(478600001)(2906002)(83380400001)(38100700002)(7696005)(66946007)(122000001)(38070700005)(86362001)(55016003)(76116006)(110136005)(8676002)(316002)(8936002)(54906003)(5660300002)(52536014)(4326008)(66446008)(41300700001)(66476007)(33656002)(55236004)(53546011)(6506007)(64756008)(9686003)(26005)(71200400001)(186003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bzcB3JOdD/81f08tP0TQPhZYbxBeeV05bJbdWQHzx8SnnbytX4e20hffXNq8?=
 =?us-ascii?Q?+PVwhR3OML1ZhC/pHNoau8Rg3kR2EvJuLIq2M5MbBxfXHEJ/13VLQw8WR9Lf?=
 =?us-ascii?Q?fsbdRiaqB2XRhBoDlqAlx8svMprxAivlK9M53MOaKn+8WFPWVUCVeJmwrT7z?=
 =?us-ascii?Q?jyNmbkN/ijlAaDhKia0dkE00qaL8RLvuZeoEldbziiz8vIf/8jB32PV2gWiH?=
 =?us-ascii?Q?HO02FqTBL14ZjYYL7NQCSLNmI0Y9GYsLb+pTHyx6/A/7//3W0Pel3AeoVe4f?=
 =?us-ascii?Q?DjemOyK19ztP3bt+aBB/GjSXjyTdNQg8BChQ4XDftHqErW3KFD+8Z03fxUk1?=
 =?us-ascii?Q?LRQK0BTLfk2w9UzfxZPFOQnlsQlbqEsQlVuVUOLR62gdlXRljeLH5vgRik/f?=
 =?us-ascii?Q?EmGDZ9YwfVk6nnvjf/+s8sa2S0z5SlAnnPG0e5vfH9GYGIYO4DTVBrH9LTEd?=
 =?us-ascii?Q?QQ4Gt47VaZofDSm5ygQBvNUKg+FOn566XfH5bBNFwo6Zm+nTMaDfWbmW1F5v?=
 =?us-ascii?Q?Azti7FZ57NAXcPXdEzTIcQ0PzZs/YdyrXYQEygzTePEfI8Twk2dqjqIIbMcP?=
 =?us-ascii?Q?ACK4r8s5GeZX6jS7u/4MjRYguyumlvG/U6OwjH8NHpoC9iJiZxXi/JZyk4dn?=
 =?us-ascii?Q?Q/u6WSiJyRB+4xAs3eb1F8vvk9SglgvHLCd3FNeiR6Y32Po0dP29ZnjPBO8g?=
 =?us-ascii?Q?4MuzMcQO1HZZhzlJstnEQkf4iBCGZrNU8//hlMlvE+GISWo+hbUGNTbxit5U?=
 =?us-ascii?Q?BpvUJ1GM0mB7cdVu3ZAUHgHC/YSHmL9e3nunqUYwfAQ1UbiIkrN++ZEuuCnQ?=
 =?us-ascii?Q?NrBV24sdYs4z3DneWBqSytowJJdM5gEf0+TmTjmw3/+bscKQgzAxxhuH8Eve?=
 =?us-ascii?Q?VkMgU4pwKYQL+sNWWULBD0hNMX+dpXxRgtExjq2RN0NIjWmew+E7UP0m0MDu?=
 =?us-ascii?Q?sK0vSw4KV2Y6awK8ghr24Hr6i20PRl7LDgqIQs/WaZXVC4Yy0yDcCnD5YPS1?=
 =?us-ascii?Q?XrBDjH+k9rgg9jHhTe+19b+PjETRJmXDKl0QT1MYFbeZU8PCNquLEmnZ1E9H?=
 =?us-ascii?Q?NkaMxeTsiNWty/8IfhsgfarUXuHJ/pAGX2afoLnwVYyMStPav01RW1Oe7HnQ?=
 =?us-ascii?Q?5au+QdufhzUzmAPx03FObReUPkgHtkbbgkV3l4qAeE2iR6S773rEauWltErr?=
 =?us-ascii?Q?cyjyyCsr6teliR7PLwh6Z7LDAPVk3bKu/VkMweJf4v2x6xVB46TwXX/xUhXC?=
 =?us-ascii?Q?S3A0cJu3cWPp1Yy9bc88OeFuT9yabYbshQjQZOPlAB4VKqKJNjoE2UAevsam?=
 =?us-ascii?Q?t/3PH8tXpP8PeE1B1qwZdFwskxD7+1dgMMf4oApLUoeUQiz+P3/QQLiu9b5o?=
 =?us-ascii?Q?vS4Q9I3qFGY89kzDIOAEYSF/MVBtwxkd2llqP6QWMnu9m1KCWJCJ136WAT1T?=
 =?us-ascii?Q?vmbwHQVpdvjt/rTIiB6Xf21nmsDFFo2aGSJ2HETIPgBRqMsqJVOr05MrehIS?=
 =?us-ascii?Q?oR+AUKhR4qS/v/tERlRKSInx0JpXI9aP2aLMOoRU0uaricqSa8hbVW5oESel?=
 =?us-ascii?Q?Dp+0OchbNBRDLDSkHLnuAiBiKZ+hlmIyBoaw8/AuSkVYnbFPhTAHJUrj0Rpm?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zwkH0EARaDeBKqS5SlLho6YSiWskRoBnug/oQwFnXnhl9Q6Pk9PrUlvUSEhjy6PLFvyP/Nci3C0FbPGy2Qonjbtsoi5omzLuAtb6G638CsZfXUVPC/a3iuW6zl7xB4CIkOkGcbnnWMNLHlmA6UERvK1cvZT7b6g9yLp2W2lKaDayHr034k9xZIyht8xJ5Ib9ZauPMJ42dl7RZIMVRCof/XK+lgpNoctDEeqOkmF+KxkJMVO0DdhKPr3lBs8r2kRCqU8tTLEVqHTNhk7HVCCBz6KcVVlliVmsQ5/TIYwLXy6yQT2ayVoF3OkaSa4p/Bx9kR+k279xaypAKCRWNP5WTYqVDCtU9ezQDJ4sEev7zUqiN61lwkLkTMCj19aThg4CMxk4wW4nyFvtAB6HQrh8YGngvxHmygWf8/fykbobfYCLq5EhLf7DzWRaeTtc+DA6AKIr2+URWGqGUpvPdpuZzS42rsy3TSoALk1IFxxjWKJILW7U13QwY3nzIis+fmvvvWO1dsGYMohsGU2GZn/MWVLNFgftkJO8zYXwuBvFx+oWjYYmPxpLaXrNqqZ7oc4X7bgNblmUaT9UpvbaZnhP5Y2cz5u4FOg2nO+U0LMm0c13ac1bBEuJMggzxKzSx1sLpw0wnoaSSLXAfuJ26Xd3pHaAib/B65AbqLiks1pltLVAx9NPdFN8GV+Wb7HbnMAM8kdReMmyt44EB8tIoy+Vkxzxq7GteAqtwjgSZGNGuuxvVBPUHaOGgqkdyuE2QbLtMicTdGyDulgUG+q/+rrkUBai3w5JoRF15/RZ01dKkGGeAzffB2kXelsdtRnvcJdCGA4HufLIHw19WgrdhVbdcQOrRM0ldrXQa/LxbKtKesFBUJFsqaI9avEordcYm6H/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500e48fd-e10e-41b7-6621-08db0b2172c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 04:44:09.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILC0rmFDz5nH4eLnEOjzzjz2SPu+FafYuS+sR1UbcMU2TZlclUf2XReV/6cyfVUEhYbt8YdcURzT7PiEvnySoLhVPcoDUD45wApqvLXqx5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_01,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100040
X-Proofpoint-GUID: yixgnULxkylW_NwcJOPSNF2wiM_A89D1
X-Proofpoint-ORIG-GUID: yixgnULxkylW_NwcJOPSNF2wiM_A89D1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, February 9, 2023 10:22 PM
> To: Leon Romanovsky <leon@kernel.org>; linux-rdma@vger.kernel.org
> Cc: Davidlohr Bueso <dbueso@suse.de>; Ira Weiny <ira.weiny@intel.com>
> Subject: [PATCH] RDMA/umem: Remove unused 'work' member from struct
> ib_umem
>=20
> It is not used now.
>=20
> Fixes: b95df5e3e459 ("drivers/IB,core: reduce scope of mmap_sem")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/rdma/ib_umem.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h index
> 92a673cd9b4fd7..95896472a82bfb 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -25,7 +25,6 @@ struct ib_umem {
>  	u32 writable : 1;
>  	u32 is_odp : 1;
>  	u32 is_dmabuf : 1;
> -	struct work_struct	work;
>  	struct sg_append_table sgt_append;
>  };
>=20
>=20
LGTM
Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>

> base-commit: 627122280c878cf5d3cda2d2c5a0a8f6a7e35cb7
> --
> 2.39.1

