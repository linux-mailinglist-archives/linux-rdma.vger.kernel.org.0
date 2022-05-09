Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7751FEAD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiEINrL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiEINrC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 09:47:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6700A26ADA6
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 06:42:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249De932023549;
        Mon, 9 May 2022 13:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HuZCIMAI16xu7mhxbcZiIqa0a2RQUBpi7GAMiQsn0pA=;
 b=WkP+bTPbvII4+LVzLgDTgn1FmG2kyFMJciTn0rwFJnKxmawACuHyOMyDD+cD76tBM9qC
 V+Hu2M0ddqSmR2J8sNgj+N4wlVstMzhC9+saxCRLaK2RsjykRQnPT5ZR0hSZBKgCDYJe
 lZ8IXF3BvmdgAzuIVbek56kePuoGA4GPfVE1Tqo126fE2RZrcwQPvnlKj0sxEnnm2/m4
 dn/5tLEhRz5l0F5H1EJQPX/uDp0GMKBaKSaKUUfom/iHQunCnc0HN2wUnu6o9U/rQaA/
 FeP/+pWFw1vcrUKiHL9UyTzS0TN+BT3Jw6YEWu0XBkZxaw5aV63yT2E1KGwBirjPl5z0 Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcskgu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 13:42:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249DYuJO024514;
        Mon, 9 May 2022 13:42:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf784ef3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 13:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdpZ6P9Gkls3pvTFMo+U/8SjugUXrskN+FqMbMovg18k25yn2qiEIqR/W95feri/MFUPgtPYKZ4/b/QfnNfdBe+APrDQuxd7LzcZQWRm6lj2xgljJVlu6LebyrHUjLjA1pwYsu2i9Xhqf4cIkGtHXcX7jmZ/WrDk0yqFqQF2NEXdQCe6orvlhbalaaDdkRu40qLIOc/eSeSJfqHaYFA2940q62xpxNnX0rvrLnHCOMCrZaqfizjoB/z/tvitkSQzkSzUbPyJ5Tdlbj47rGoYbdpRPo+/kRgJWRdl4vyH7xJWfIBWtfwI5QISVIUuYf1qZYauWVsv6KJhj0Dmk0CiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuZCIMAI16xu7mhxbcZiIqa0a2RQUBpi7GAMiQsn0pA=;
 b=SbVKXW2a4jntQydAd9KN8PRYLLeuxkJOI89rcrebBKGf4lqVOSq45Ef4oqE5S4y12eQ56wx8zdhyCBUvJ3u6UUDxUnIE3kmJs7JXSOy1TK4Mo7qfZz7q5Q7bfOFi/XhVkSgmdrZ0AoiRxgQ0CgRBkxYem7VfxME/ZTxs3f3psE1hqmRL38e10WE2sRFbGtXto3L5sOT9U0CSHPedXJZDFZje0e1w6m0vEdoDsdD00zNPX8IJLxBsFjzUb03Q/cmylaM8RhZnx9xBeoglPvg14g4VBQTJM0uV0YFyD2gNgApeKSS/yuGbdJLb+9bEQbNwDF/Dr8BjjGxgG21rR/h6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuZCIMAI16xu7mhxbcZiIqa0a2RQUBpi7GAMiQsn0pA=;
 b=LMUDTjfnznm3Oz2DtUMHGpXbSL7kF1bTjJPO+Tk7qb1PcjiA1Tp6gARKu5P2jCKonpHzfYTwYMGwc/j19zMYQf31qPfF1Nzg4JXazhOE5h/E0RfCxGSCrh+A93ruW3Wb1vjCMgRnUx2NPXB0Auh5/EQ6oFOCZoYWj6wt0mqHYc8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1317.namprd10.prod.outlook.com (2603:10b6:903:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 13:41:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 13:41:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Enable siw on tunnel devices
Thread-Topic: [PATCH] RDMA/siw: Enable siw on tunnel devices
Thread-Index: AdhdZknq2jgD5B2IR0yMDpmefDAxhABBnM2AAU90IwA=
Date:   Mon, 9 May 2022 13:41:59 +0000
Message-ID: <E672E593-599B-4750-80B5-8785F1DC9B3F@oracle.com>
References: <BYAPR15MB2631F0F28155C7DDDD1BCCFD99FE9@BYAPR15MB2631.namprd15.prod.outlook.com>
 <551A5533-B4B0-4075-A1F4-F8899F7C8B77@oracle.com>
In-Reply-To: <551A5533-B4B0-4075-A1F4-F8899F7C8B77@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aded8716-c3ab-4220-4224-08da31c1b0d7
x-ms-traffictypediagnostic: CY4PR10MB1317:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1317DC7EA104F3A5957F753393C69@CY4PR10MB1317.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2od4NuKWZuJgdgS80EhALnsSGtHqOMeqcqrSA0jZmTpkwOxumJuMhcUM/F6QxA34XlBbhXWTVk81kY0Mel1zauCpiCKpVpx+aRRQHGSdL01BBCy4SYq51yKCme/T8prIyaTsmmVx00Bno9baYvDj8mZHXv6W/6xS+tw51qkYFo0D5gqY/92fC5IEFufQ0isSPf+ZiTVnxtT3TM/L2RKggZLCsyPzN6ph+b9kBRMBi7PURVSLhk0wY7hwZXzoqoiE/591/ROOt+Vap18B8G+V6aZ25dJiOuwMvyGeR4HCzutVT8/UkRRNFrFxVvJA78MD/RYHPdBk++2HVqwfMKu/fFnNaA5XOkWN+svqSBqi7nCGoBH0lHOncvjrG/Lmlf34KVckGm2YCBMwa2JfrFS+3pTGH6Ibc7srlor5g7lYKJ8d8bcYIxzeuS8/30tnQdVPNwGh9ue/fP2xi6LDQ51/mxK9ElnVRrHfe4C049MsKgcvDGpAwh1K1V7kD3vOuvIpkbdaym08LKtQ83U1IzQPP3vJUIAtZF9q5toufi8naasg47tB3JJpa11s5NWR8r+ejpDi36aY0X+qRXZbQdi7xDUZHo1K/i842rd0ViIckxtdzCB4J7tbkJXfKJJjBgxrpVj4TGOpyqcVjD7TuDhHs0aNU6AjfzUl9GTn1+NNjdPp7Hi3D+4s+Wgfxor6is48my+2tf3eQ3iJIlScvzvToDkgEUaT0IFPEmFVbGHRvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(316002)(122000001)(36756003)(83380400001)(2616005)(38100700002)(8936002)(33656002)(66446008)(76116006)(66946007)(66556008)(4326008)(8676002)(64756008)(6916009)(66476007)(38070700005)(6486002)(53546011)(6512007)(26005)(71200400001)(508600001)(2906002)(5660300002)(186003)(86362001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ngzkT4ABuV8D78aaf9JGlOapED6hfy2ONoBdsYyZcmTy0WDsyFR9YM4SAYG?=
 =?us-ascii?Q?hAH5BC8j+ITIkQu3VidYCVGiB2UdZiqO7b67rbWOuendc7a0NoQwPUBl8e0X?=
 =?us-ascii?Q?kFj8K74YBTIOBpOEyH8V1RH4RW0QTsWZNH6QkWBxLBGBLKzRykLYENoa/RBI?=
 =?us-ascii?Q?2mIhdV5/11kULAicHcQbAub0BlOfcOhNVjcLBpmTLZtVt539ZhqDMorN2JZ/?=
 =?us-ascii?Q?dCnD2RtJ3o2j1xaaNtXrKYhhkKlYRV74qCrBVObpSAUuDyv/5QH1YCJpr2Kz?=
 =?us-ascii?Q?MEUQlzVOFkKQCF4P+w5PZzlWPyaRputc/SJWOVsjiOb10R+AQy7ksFb4QA1r?=
 =?us-ascii?Q?z9Eg+tKxcJbNMe/2yh5srG3jRO7mb1s9/0vjqXp4LBwIdgwTFWVWzjHmEQjm?=
 =?us-ascii?Q?czJK0xaRtx+FYrhXZdqUJPBA0R/JPNoQ2hxKskYpKf8p9uyvo8H1J7fJDQkG?=
 =?us-ascii?Q?qxlixr/89PmGMdoKJjqweNriyR0EmAEttJ6tTuGPPzmjkRDfBcwszsn/+Rjo?=
 =?us-ascii?Q?oIyergLHvtQTkYM1/cN0mvigxTmsBwBCaoCETajaEHF3EniGdt6oQghYWMDd?=
 =?us-ascii?Q?uYIkDyw3QNwklMLbvcrUX09bfDViQtqyz7jkHprbHZLTlxwYvr6Y/zoUtnMK?=
 =?us-ascii?Q?MebccexYzOLpvvhFET7u07K7ZxkZbeS6002FzzDm9PP2qxDuoXRZXDvMIkV1?=
 =?us-ascii?Q?qk2aY/F9AH7ZzI2f5Nl2dZMhnpamVCTkt+KWSg50G3Qy/AqENFW9yca4h1Cc?=
 =?us-ascii?Q?r7yZUVJAeTUj2/mUNpaZs8zIeMcQ/cgUQ1h3j21ykbBIpkcmFR3dybaNofco?=
 =?us-ascii?Q?gzOu15kJFf5L+5ZW9D9h59w4HLYP80ajWRXOewfHDhQ97xcuL29uGYlaaQ+0?=
 =?us-ascii?Q?gzsCCQgrtZPdarhdv2uWbnUE9iqPx4bGFyYJ3ovZbAUj6Yp4isvmik0l1HNz?=
 =?us-ascii?Q?nilDfs4WAC3PGl5llfGa0QahgTGexMdxHSPJHipUn7vSZgikOSh5hFlGcDzs?=
 =?us-ascii?Q?CU/IO9USITbShgPhKDJmaQnGKKAcRQriWosBQIZq4ZnLSF0d0ni7WaUqu6nP?=
 =?us-ascii?Q?89u+AOX5b0N30IO5XoP+xXN8ZzcasH3KNaOxN/QifqJdsOR1JrHmlv1kmlqF?=
 =?us-ascii?Q?nE+z+Z1FruXMjmna8C+x71Vfq1GvO4ZWW1DDwZrqTW0SUafAcQuQqJj9AXR0?=
 =?us-ascii?Q?9a82hTY0bOpznJwE2RUyrK2EgtpyTnrMLDvruGXlRwqeFBHTNYXXO0offjfV?=
 =?us-ascii?Q?olxfnUxXJY8ZR1MC6nGIowLeJd+ES+r0JA1XN4ULnAPbnjdb2Zvh1VD6Xmjb?=
 =?us-ascii?Q?826zR42sdoLOfzEDEFtvtuzqazfqg0EjJkSCKTn+MzCCK9j8VRhLtJsVmqTo?=
 =?us-ascii?Q?8+ipeUkbrrqLf6gh/ALzKn0hsVUHZ6CTK7Fu1LVE1rA576IwpRUmoBva8WbU?=
 =?us-ascii?Q?KxQp1iglEJbNhrCgPLiNrKa8SN0I0IqdNxNYjAboEUKjitaEU1MbV1PArn2d?=
 =?us-ascii?Q?0/1owttKjwy9jh4rR/Hmaw2K4ic9fAN9XRBW+N7qyif2EANv0AYASGrvTT4o?=
 =?us-ascii?Q?zx3l0XdS8yOSu4iSbumLzlVnqyXq+/r6hKFdq+Kuyl1ddPFdqYDLUZiGBmU1?=
 =?us-ascii?Q?zOIdArXAWiYjngNTLkJCiOIhJeTSlhlf19mOrpsT+DL1YxqFX2ViZwnGFxf4?=
 =?us-ascii?Q?JF1Q079WxX15Fw8ZOpl97+eLymBksa79VHFvqj/RoD5J3V95l8GUdx801dWE?=
 =?us-ascii?Q?6f5/wtIiguWY65YQ9BtvdJkk63B9Dlk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F4D0B9F41D7054FBA46945ACE2D2A95@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aded8716-c3ab-4220-4224-08da31c1b0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 13:41:59.1380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB3iyKTJjJQrrbQoSulpJFgz35DO2NuU61kgoRX7cclIon5xkd6LF9+/u7k/4BWiM+UsixGlcCy3oDmSJ76Wsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_03:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090077
X-Proofpoint-GUID: 2xv5pCK6ZVwu7jys8UiI2NrsIz2JTFy0
X-Proofpoint-ORIG-GUID: 2xv5pCK6ZVwu7jys8UiI2NrsIz2JTFy0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On May 2, 2022, at 5:36 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On May 1, 2022, at 10:18 AM, Bernard Metzler <bmt@zurich.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> -----Original Message-----
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> Sent: Thursday, 28 April 2022 19:49
>>> To: Bernard Metzler <BMT@zurich.ibm.com>
>>> Cc: linux-rdma@vger.kernel.org
>>> Subject: [EXTERNAL] [PATCH] RDMA/siw: Enable siw on tunnel devices
>>>=20
>>> From: Bernard Metzler <bmt@zurich.ibm.com>
>>>=20
>>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>>> ---
>>> drivers/infiniband/sw/siw/siw_main.c |    5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>=20
>>>=20
>>> Hi Bernard!
>>>=20
>>> How come this change isn't in the upstream siw driver yet?
>>>=20
>>>=20
>>=20
>> Hi Chuck,
>> Good question! Did I ever send the patch to linux-rdma, or was
>> that conversation off-list? Sorry for asking, I can't find it in my
>> or linux-rdma history...
>=20
> I don't recall seeing this patch on the public mailing list.
> The conversation was between Ben Coddington, you, and me, as
> I recall.

Would a Tested-by help? ;-)

Tested-by: Chuck Lever <chuck.lever@oracle.com>


>> Thank you!
>> Bernard
>>=20
>>=20
>>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>>> b/drivers/infiniband/sw/siw/siw_main.c
>>> index e5c586913d0b..dacc174604bf 100644
>>> --- a/drivers/infiniband/sw/siw/siw_main.c
>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>>> @@ -119,6 +119,7 @@ static int siw_dev_qualified(struct net_device
>>> *netdev)
>>> 	 * <linux/if_arp.h> for type identifiers.
>>> 	 */
>>> 	if (netdev->type =3D=3D ARPHRD_ETHER || netdev->type =3D=3D
>>> ARPHRD_IEEE802 ||
>>> +	    netdev->type =3D=3D ARPHRD_NONE ||
>>> 	    (netdev->type =3D=3D ARPHRD_LOOPBACK && loopback_enabled))
>>> 		return 1;
>>>=20
>>> @@ -315,12 +316,12 @@ static struct siw_device *siw_device_create(struc=
t
>>> net_device *netdev)
>>>=20
>>> 	sdev->netdev =3D netdev;
>>>=20
>>> -	if (netdev->type !=3D ARPHRD_LOOPBACK) {
>>> +	if (netdev->type !=3D ARPHRD_LOOPBACK && netdev->type !=3D
>>> ARPHRD_NONE) {
>>> 		addrconf_addr_eui48((unsigned char *)&base_dev-
>>>> node_guid,
>>> 				    netdev->dev_addr);
>>> 	} else {
>>> 		/*
>>> -		 * The loopback device does not have a HW address,
>>> +		 * This device does not have a HW address,
>>> 		 * but connection mangagement lib expects gid !=3D 0
>>> 		 */
>>> 		size_t len =3D min_t(size_t, strlen(base_dev->name), 6);
>=20
> --
> Chuck Lever

--
Chuck Lever



