Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D28517936
	for <lists+linux-rdma@lfdr.de>; Mon,  2 May 2022 23:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiEBVkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 May 2022 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbiEBVka (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 May 2022 17:40:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591564D6
        for <linux-rdma@vger.kernel.org>; Mon,  2 May 2022 14:37:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242I90qD032436;
        Mon, 2 May 2022 21:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+gZpd04Q7TJQCehjz/ZLi64PHJVtoyDNUS2Oq18ycfE=;
 b=w8loe1hJ2LzapiqBLM4+csW5mvAmYkgd+XpKB0vAHXAcMo0/lG2xrR/iXK8QWpXx7Bx2
 fbbt6h2GH4yvpk8jOCarjhhjUKNc/A7G6AP45m5SxiLIemcqikVrFKHuLT45WDIm8ZM6
 a8z6VT11QHcpAZLCUX3iIGrjfv5eDO2d3pOPXAWdp36KhOTJW6mMOsuNtiuNfHRL7P7H
 ZuKR0ZIR4AuZBqX6gvKBZJ50W8sQQWh+JKhUvWD5Zg53xTjyo6qaq5PkyAxfydyBXTKc
 G+ygzBNbLSXJMPYaLuVMBQ1iZ+wINpRVoczZBRhqnrr2zRA94TmCEHDbTe7nVOIigF5H sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amabd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:36:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242LZOxS033255;
        Mon, 2 May 2022 21:36:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbksv9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNAe5dzBXEgINntzOHboIvn64aNygSmObIF4SBGqU5gVthSChNLK0e59IL2kz7kImE8qR+MPkOMt2zlTSnJUa8y/DG98q0rdQxAAfVPY+h0IdVnvanu0Q+cYEJZ4QXw+mIIp5xoV1SG/eEHo6ctM0loRpIFVLG9hZjzYAIddq7GOkKCAUaxAm21gDG6Qv4YvZC78xjSYzlbMTv8w+WXKHMM9Alo7kNeisJ32xMWPWWv9Um44k7J5blLeoPX4DBXUfXnLMAXaPIWAniiTUjNTdyvvpvBufIs7KScgRshZPt61+z0jDYumvOSTrdWnNjy7A/CVXv7qxRemiOCugMmxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gZpd04Q7TJQCehjz/ZLi64PHJVtoyDNUS2Oq18ycfE=;
 b=N2ZI1KLGarfzyf56u2OqsuSAOqDmuBLX6HbciF4177ouFVkSB88mBsMUCnPM4MNZD7LJEXlRKRH8XZPFvubGbHREfjErKrM/x34UBl58R6Wp3BZW9sKhl2BN/Nlml9jQqOU1Q3g25/HulOJABuedU71DlDIeWnCqCi0jU9viWHeKLsHGARMJ1Ne+QrJtwe6AljAdcnxCpdjV5F3xABegPbhVggSPwWH7zEQMByt0rSOjIv32+eVU55IvRwURy/NUHtESxZ91PlLnaNAGCwUAp106qSY9nR837reDm0Auheap4E8rHJfscmwjWkbYpFiF3XeLuwtCqL7fg8AvNkPoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gZpd04Q7TJQCehjz/ZLi64PHJVtoyDNUS2Oq18ycfE=;
 b=hrXu/6Svb4p5elTWlPF/XGLTvRmfoQsexwagCVrYvQlGIthdLa+MZxWgkKzOgPKfhs0gD5Ku5zmUiZZTWJemiwDBpkekN8H3yoinDEBs6WRdmnZG4awZ9HUmV+EkeGah5ygUHEsvE3M20vMmuREG2XUnjrZnczeXSom/Vp923TY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3448.namprd10.prod.outlook.com (2603:10b6:a03:88::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 2 May
 2022 21:36:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Mon, 2 May 2022
 21:36:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Enable siw on tunnel devices
Thread-Topic: [PATCH] RDMA/siw: Enable siw on tunnel devices
Thread-Index: AdhdZknq2jgD5B2IR0yMDpmefDAxhABBnM2A
Date:   Mon, 2 May 2022 21:36:55 +0000
Message-ID: <551A5533-B4B0-4075-A1F4-F8899F7C8B77@oracle.com>
References: <BYAPR15MB2631F0F28155C7DDDD1BCCFD99FE9@BYAPR15MB2631.namprd15.prod.outlook.com>
In-Reply-To: <BYAPR15MB2631F0F28155C7DDDD1BCCFD99FE9@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ab1b9c0-91d6-41ac-1c55-08da2c83e0de
x-ms-traffictypediagnostic: BYAPR10MB3448:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3448ABD1F7721B88048AB27A93C19@BYAPR10MB3448.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pg4AMJdl5f7xhDg67wC/OtAuQVROP1QYNlvXS9HNFZs1abSuLjbgQjVhAEMocVqDgWRS10/bkAOfTh/y9E1rRx6CB0d4lCMvuPD5cp12ZAM7icDc+0q6mSviUkLCCYvu3Xx6nOYKB7ot7kPx392WYGs5cKvBOXtyeg9xw6RZcABiYUpGA1EjLsOVxpnfM1sc3O7BdanWsVz5zNWKBx+BA7rkO3EL5Togtxnuw3bJBfiK9LPSBcYwNPtsKmYMCOnJj8HK6uFGWGLk8LZWr3ADI1st+HVfiN4dTjbErWNqBLnxIAcj9E5DXC9iqT9/UM8YzW68l4HunN7GDraTjDxTWgNn8QRWN5o6ohU545gw4PZZgFKbq/d7Aq0ld4JLmY1+eB82392ssG95+ZtDrMql7yuUXOLoS9uBs/QDJdIj1aHW+CwCxF1/mFOQ2eU6qig8CRfbLNLxHpLxmgTREewBIbc36enCjXFfOX4r+TsQeGqlFMP5zTpcSskPQTEG46PvzgP6UU01C3+3U6gKzmsaCpXPZLhJUE2zHxvzr/kBilfMaA4Ip05RYIsbLTtYQTicP9+02UvVEzCYMxWa4f8NM+cjQGpzCynHFdx+LRViAmbsSzkG/R+0A+RtacsnuYwN+DoV2lzuX7i37KSfWiwm8PBY1zjgdIld2OcvPYWZkkJYZnDkD0B9Sgz9iPaMBUvVPjEf+KQ2RbeGPcMwG0rUvaKjDSfkfb5gN55mDvocQbgczGCEYttSpmQOk7vdC2eH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6486002)(36756003)(508600001)(33656002)(66446008)(66476007)(66556008)(66946007)(64756008)(4326008)(8676002)(71200400001)(91956017)(76116006)(6916009)(8936002)(5660300002)(316002)(53546011)(2616005)(26005)(186003)(6506007)(6512007)(2906002)(86362001)(122000001)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ktpK+D3hD89T6WZpxt1j3MlPhO+uYhErf+QXFIXyJfypeG5QM4pOZDyb61ql?=
 =?us-ascii?Q?h9TjPURjDlRjaioX3M1Tsrj6gq6mzUI1r8G3buDA1O6rZQtiy2MGH5+Li4TI?=
 =?us-ascii?Q?ceXl5wHvU4oTWXCjyeJ+r1tMan3+JATXY4u/7IocLX6QnkA6yI0Uhw+mXGgI?=
 =?us-ascii?Q?BLBPgTDAAmm3H4P3jmNkvty9Ei4jdhkiLk9PXN1s4dRx7JjYHQK+K9VpGy+S?=
 =?us-ascii?Q?GPuIH+GhzIpdFL5xyy1JE4UNRULnz+USIVyUJKBs+X7Y4iKQ0LqdrvaAo72k?=
 =?us-ascii?Q?kzaxNWeUkLQ7hRKeL6FY0EFI9/GcyTceSrDcX3aACLtGfrIHMpgCj8TV0/8X?=
 =?us-ascii?Q?YLufXOJj8QnoSaTqq2yxShFbEUBHwoDU1QGIZkibCZXyoY8Ew6EnSCka3OnY?=
 =?us-ascii?Q?i2zE532m1nBTV3RoUUed2dig3XQL/mU77ZrqV5ER/zWeGZyYb6+w7vv2UYid?=
 =?us-ascii?Q?Rht1Y1foGnX69Y9Xh9TAW3v3iK003hC6H5+qpc37/GLk/xC01m5c9HnanmLt?=
 =?us-ascii?Q?HPgrFGvnNOHB9YWu2hBubi5YuKgV5NUbIcEYpJR7JFrVDpdXzcqvI0FC1g5D?=
 =?us-ascii?Q?mXMFQZ2k9yHxnPkbRUDKoU1NzqU6/4Jyfq6aWv/9R8hzIXVOMF9hdcEoWXcN?=
 =?us-ascii?Q?Z1Jdjl9wU5h+NbQEW4crG3CAlrS0Dt8KlrDKLeBkT2l86WvNoS5Uth4462Wc?=
 =?us-ascii?Q?rSvVjKGwUlYP4Hi4UqTff/J6JsIhIuWr+XkDJgY50kx+iguSPIjgFAEJX5R/?=
 =?us-ascii?Q?OxRH6wG6Y50vR0Sw91nB7nfMv+CxsOF76Vrr05nYuESh/PiylC13P5dvJ2Ye?=
 =?us-ascii?Q?+pFCE+i7ePZK3hxu7qWlCDQTUVKZzKo/v0HNokvEqbh7XtIjwIBFRYBLXK4b?=
 =?us-ascii?Q?XqRchoLK5C0+mZEyDj8LVXHimPxmnbrnDjOMH4hiwRp0Oq4ZZKbWEUF4WqFy?=
 =?us-ascii?Q?EFMhAvPWTp2pwSf4Z/hg3ephJaNZFSQpUUJPqjZFOtX80Wk6rKAu/IMb767M?=
 =?us-ascii?Q?lHhamZdRqAIDttwBUvyuZSlhdrFjGcHlyQZKpvv2qJp5puw1ou0SOw6WzjQh?=
 =?us-ascii?Q?8CxeJLeA5K0/5U/DsaETaY5Lq8ZgjG9doCA4ctkuQ6rkYgu29VR6b32smTcp?=
 =?us-ascii?Q?KmgYe5QeSYvx9ZRUpIz/nmNzmE6epsMbF68lREoTsGUzyVKvbCorOs6oa3Bf?=
 =?us-ascii?Q?73pmfzyMassyxlAPBWCN07imFdmlyp3xPFy3YeJ+JHCcYCN5XYQb+7+0PXu1?=
 =?us-ascii?Q?hc1HCmUVA8mflqCJJIHI27K4rj7pVYW5cX1CFmTamETvGkLV1dE45rIXwYee?=
 =?us-ascii?Q?58HEH2kyMUhXkq8te1zojFWI56wfys/fL6EEMICZszkb7AjvLXLV1aTQoiml?=
 =?us-ascii?Q?dJ9tlrK+AdGc9Q5kVstRRwWATZeQVWBJCQmcadf3i9rIyitvaOZbKgpYvFhK?=
 =?us-ascii?Q?su0zkdXfCHjiNWJjXEZOSTjUjSHG3XnnIuelPrK6ALdgJ+MyfJFjR2yI4twe?=
 =?us-ascii?Q?7890CH3Rax1z9+Ic31KHGE1dncksa0cVnwPSjS+joHAfZ5fqUaevrCXr5QS3?=
 =?us-ascii?Q?Bo6/qVh9YSyHhsVGqY8nQL/8XISKGSoyuhtj1r7+TjEfg8cfp/npNjhzfpOP?=
 =?us-ascii?Q?1EqZIEjxJk+W+6kELetJ3tgDJcOBlfGYRHwJcGU6nAPiyXD/6HJXpr9h+dUs?=
 =?us-ascii?Q?zWZnU9BW3SPd6Q194ITkRQ+mwy2WDI1lmMYkMOp0KwB9Au/zYKCJuVRaB4mZ?=
 =?us-ascii?Q?aSZRulifGFgfObRJFVq/7umN+HXE09M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB480FF15C43AD4BB148A41564F3147A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab1b9c0-91d6-41ac-1c55-08da2c83e0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 21:36:55.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFWoLxcFKoJOaIZrpGar5OC2u2OGsiLxBqTKlLxy7pAblY6dZkgYP6MAakOePpj40a9XnA9cX9mzh3WvSiEVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3448
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_07:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020159
X-Proofpoint-GUID: H5CiL3L3Q1EzLaTdLc-Y0Q3cQ38JfCP5
X-Proofpoint-ORIG-GUID: H5CiL3L3Q1EzLaTdLc-Y0Q3cQ38JfCP5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On May 1, 2022, at 10:18 AM, Bernard Metzler <bmt@zurich.ibm.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Chuck Lever <chuck.lever@oracle.com>
>> Sent: Thursday, 28 April 2022 19:49
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH] RDMA/siw: Enable siw on tunnel devices
>>=20
>> From: Bernard Metzler <bmt@zurich.ibm.com>
>>=20
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>> drivers/infiniband/sw/siw/siw_main.c |    5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>>=20
>> Hi Bernard!
>>=20
>> How come this change isn't in the upstream siw driver yet?
>>=20
>>=20
>=20
> Hi Chuck,
> Good question! Did I ever send the patch to linux-rdma, or was
> that conversation off-list? Sorry for asking, I can't find it in my
> or linux-rdma history...

I don't recall seeing this patch on the public mailing list.
The conversation was between Ben Coddington, you, and me, as
I recall.


> Thank you!
> Bernard
>=20
>=20
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>> b/drivers/infiniband/sw/siw/siw_main.c
>> index e5c586913d0b..dacc174604bf 100644
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -119,6 +119,7 @@ static int siw_dev_qualified(struct net_device
>> *netdev)
>> 	 * <linux/if_arp.h> for type identifiers.
>> 	 */
>> 	if (netdev->type =3D=3D ARPHRD_ETHER || netdev->type =3D=3D
>> ARPHRD_IEEE802 ||
>> +	    netdev->type =3D=3D ARPHRD_NONE ||
>> 	    (netdev->type =3D=3D ARPHRD_LOOPBACK && loopback_enabled))
>> 		return 1;
>>=20
>> @@ -315,12 +316,12 @@ static struct siw_device *siw_device_create(struct
>> net_device *netdev)
>>=20
>> 	sdev->netdev =3D netdev;
>>=20
>> -	if (netdev->type !=3D ARPHRD_LOOPBACK) {
>> +	if (netdev->type !=3D ARPHRD_LOOPBACK && netdev->type !=3D
>> ARPHRD_NONE) {
>> 		addrconf_addr_eui48((unsigned char *)&base_dev-
>>> node_guid,
>> 				    netdev->dev_addr);
>> 	} else {
>> 		/*
>> -		 * The loopback device does not have a HW address,
>> +		 * This device does not have a HW address,
>> 		 * but connection mangagement lib expects gid !=3D 0
>> 		 */
>> 		size_t len =3D min_t(size_t, strlen(base_dev->name), 6);

--
Chuck Lever



