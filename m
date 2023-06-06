Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE117244D2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjFFNtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjFFNtX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 09:49:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B210DB
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 06:49:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DDwwA005736;
        Tue, 6 Jun 2023 13:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+dxc3Yu825VSJbfa6fopktcXoGW2evZU9emKaNNLNqY=;
 b=hdDy7c95tjcrh6NXBFBgccFC6IYiV9a5m7AlPYAnLXNXyjVop2Uv2wql/FUGv3RvjIu+
 uxjUfOyqsKeKz+M4X27AJaVsQSOg706tsSeJz0zU+jkeeBaaLBf8tdkTyTJ51xJT7ELL
 Oszbh7AmT6Tthf9fz5juFDYyD/ZWvQc5+0Psx/AqbzWbi2feGjOrF4pDGZuzePoDmssO
 du5o+j0O4qJTyASQp+9yCOtaXibRADdINuH/Iie5bDgkLNF8vUNJXMT48PO3hMoOPzst
 mzh0WjdnVgSM1KjY260NMWaZzFWYjpDN7N03uHrx4jxoWRSvbW0LvOgl/WaiOuXXeAfT gQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2wnd2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 13:49:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356CLugN011637;
        Tue, 6 Jun 2023 13:49:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tk0df5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 13:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmkz3gvyleu/DnPYPvWrOBcJ6GrAJqRdCPJKsHg1cguoF/NQO8yUYn5P9GdtfXciHc5CI1KjDpnuf+SwU85KsW3QsBuh3n/f0f1Jiv3RXsuvtsvqM3jiTfcHhMv8YZBVINie83/0Da1FZK9+qtyYXkaxuyRt2HLCCwNCiU+XZPxM3zfuFToTnC5+9fyrNKXBu3z5B99taHtw9k8zG3P9NYm3tV1JOuWDzZxQ48jhd007BlWS2g6Ook7cu5U/D+jkJSLtr4sOgueiRXk/sXcOBKXQb1VzpN+ycicNDzC9s9w5g4g8rGi1qeu0XjvQaRzvemevwHWL/qfPn11RB68cUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dxc3Yu825VSJbfa6fopktcXoGW2evZU9emKaNNLNqY=;
 b=M21keUaKl+rYwkjiB8QehMhzvkwk71qB9DWpk1f2Zoj5X/yQxolNOwQoYJYnPfMYZV8Q9CMLwsDtgpEQBA67Fha9OebCuWSM0akNRcrNSws/9YEoCv2j06gWWjf4P2dc3NOqbBl4dW9IZO2m/31lHSwotCwO4BDtd8tBMKuFmVXl5Dp+bm3ZTpUQkm0TIWSilnGoHtDyaH5R6pKM/+tAqNjSGJCpZWBt3VIpQU8isL6Qs4sX1QUoXeHMSXgN2DOK2tn4pa/kQAVdtw8zPVBjiqwP38JzzQjAWvRw4V4MJ/6r+Ng4PReXaU8H8G4eihkUlZGuf1Wd45Z6xtiNBkYo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dxc3Yu825VSJbfa6fopktcXoGW2evZU9emKaNNLNqY=;
 b=VPbnkwDSN32kz5u7xm3K3LiiIbqKAJPOfX/egQoOC4pt3cNgz8MZNVZYqshiwsgpqs1+ccFNb7gjcIp9YXTFxtYUx7bCRk5XJLNsJh6eObL19oaBpmYAdoUS9N++aFN+Gdf0tOG9vvtwLCCvsbcLgw9YGdF/G5i1PQBGz5N0Y60=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7663.namprd10.prod.outlook.com (2603:10b6:806:38e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 13:49:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 13:49:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: detected field-spanning write in set_eth_seg()
Thread-Topic: detected field-spanning write in set_eth_seg()
Thread-Index: AQHZmH2q2u/lvkVjQUuARjFD2PhuJA==
Date:   Tue, 6 Jun 2023 13:49:07 +0000
Message-ID: <0F4F466B-D69F-44AD-83C0-E20106191836@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7663:EE_
x-ms-office365-filtering-correlation-id: 43bc3248-9359-46ab-2a36-08db6694cc98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4n1Y5gAuFcF/+p9vfsMvo6JZNNtrAtwKCPhewzlGTbQoWrByukapAuTFpXGX8AeliWZYuqAICoNR5Xj564mI6mEvSsFZrI/V7gCbty7SR5Msf+DvGv4UvCIHTSjHEnKnviHnSCWhYMaXu1eQu9FQ7CYJGWdIQMWP3pP4C7ebMWtVeK0tVZ3LAPhaG62NFSnc7ms69KceF3xxG597dYD58znr6Z1hxS2l/76HCFrMGHsOnKb8XWnrEZi9nvu127qhmDXzVJR9m9Tm4kX0AmYhy1h2oLW/Y+a1hi7eAtzw1MWhlDV16h2dyPFyR61gLz9JCgWxLkiztkISN9PLEwlX3MwaXXYjcAats0SBV1vqPCNwJSJIAvjzasyjIeu0u8KuGj+UMEZpRbjtraljdf8bfrg4y+vaBGGw1OWdeQMzRr8iVrNTSlzlANHdkLXOBzEOCGgXbzQoZj2FfX9uhBioJgqPGOEPZmlwZOpYbm4GMT9AtZ3KOkQSfMC3n5iiwunIQE6X+LyurtPZKisnjGe/k57rTm92B2YXAWOL7juPvfaYWWKZ9lejnLLjn5U8x6CdWV71hBA6uzQEnMxceiKEPQw2qfx81/9OuU4m2u90xiAOj61o6j9m28xoBr0cfveWq3Azaut3jHZFE5yl9MZjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(2906002)(71200400001)(8676002)(8936002)(110136005)(33656002)(478600001)(66446008)(45080400002)(122000001)(5660300002)(38070700005)(86362001)(38100700002)(4326008)(66476007)(41300700001)(316002)(66556008)(76116006)(91956017)(66946007)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EyaNTFQERxB2cMXWKDMqODyh2Xpkh8ifZVHAM/6OJu37j/APWKAYWpeJdVDL?=
 =?us-ascii?Q?3Vln8SByux4ret8x7v1nu5Tu913vcjyhs6Z+ofPleFA6NoInhhgHZ4N/eyOj?=
 =?us-ascii?Q?fXv+sEiJNSDL+Zpy/xqPqUi924TulE/OopUTnGPDAHJfILPMAgMQr9KOHqUi?=
 =?us-ascii?Q?coRp3iYqUcpMsUqOQSDgSdS8Rq5q+KWuTZb4MM0BSgT+IvxEfaUG8vV8G2o8?=
 =?us-ascii?Q?X9wdUvi4oQutnjOJz4I1DpNUNCgjju4hXoflEvGIMADlWegLe/PYqfSGubyV?=
 =?us-ascii?Q?TMNl/6ONtmYbuSWTEc7+iCu3tC/sVnpODjHuMlzNDOHWVFnKtDsZ4IUgur2K?=
 =?us-ascii?Q?qP72Gz2YHAvYhLgQvb3mTu/IpcJvvYSRjp6Sjb+Dw4QOl4BuJb4LMSMklanm?=
 =?us-ascii?Q?MfJRpXEfUQnnxZm/5BQvqMLZNDjvDoXb5bUBpvRWfPHkiC156vrQ8kLSy8zs?=
 =?us-ascii?Q?MfFesD9KDcUTIRW4ppDPB/Cblllw4xrpJbet6ii7XVHlbakAv4QthhPdcOhq?=
 =?us-ascii?Q?QaSH5ZJ9shJIHf8Wc8Gc9q4fpZCgWKN3EAVh1vHemola3WWLZu0DnikROmxO?=
 =?us-ascii?Q?VIS87fcsNvG1di9cxhv7XSEzpj0JMKjQXo0spgtcQTPGsaiZ7kbHSgq4pbtH?=
 =?us-ascii?Q?aUU9n+w5vKGOeX5aOlkwQkbi8d7wZv+kRE4nwD6wS0f47kSbxuLsEXblxOXM?=
 =?us-ascii?Q?61ubu/sZHPPpDe5qRQSZqnX/Acjm3wCaQDtXlFQRGvub+V0jjdKFe6sJDefB?=
 =?us-ascii?Q?q2GI93F3KXGi2+IzcfywY6Iy3njX8IG4YEW5LuPHeGQY/LLLkVoZvuQLAvCS?=
 =?us-ascii?Q?stQlIOI9Vwa9SOqY5izwh+CXCM+7hw03dkVPJH4/hQXgVCP3asXRZseb2RoP?=
 =?us-ascii?Q?2M6GiLTauxC389YZexHLfucSlHDlrDJIxOMqyF4SizuGwiBY+1i0HX7fpoT8?=
 =?us-ascii?Q?rw3DFM1wC2D87dYkdnqXAiPTBy5V2oH6wqaTAYvoAyojDDgrx44wJ6902CMN?=
 =?us-ascii?Q?TBLOMRmPblhx5K+7pc/lUUEVe02qmWSZBEwKfsrJM/fwrrGIHoAAvll+Ttm7?=
 =?us-ascii?Q?hhD6fXrc8KMLk7B/HlTK+vcCCw25xq2+JB3cirCb1moNUpFvIWdQVN74Q9rx?=
 =?us-ascii?Q?tovToVQH2kfNj//7mvYWCJV4ExnhjUSQiy2IoBdt/5QBxzgww2owypmWMuVE?=
 =?us-ascii?Q?sIE3bYZAXXgvzLfkhqC2jBXw+JqDU3OL3WRmXbyBFFUftEjRI2GMXLFBMMSQ?=
 =?us-ascii?Q?E2PCWk85yNfLjOGb+eufM/oKn3SdN57X10CCl0sS7fjZYFv9Yl12XhcdVP4j?=
 =?us-ascii?Q?Adk6Yy4AMdKrth09zM4MUXEZ0L4OXJWi7l+Qmiyqsa/q8h0Q1bdGL9E9Wlln?=
 =?us-ascii?Q?Rb4/XTvSbAXsRIv+vZ3E3cFfDu499gNsOnz5WKZL0TztqXkG5WuEm3gO1PqL?=
 =?us-ascii?Q?Eu0onpT6BB+vlrtYRPA+JJrp+qqFJW+M1cdooxzjoDAN177BHpEJLbTva0Dl?=
 =?us-ascii?Q?d3zQwPZ3nn6ffoUls/2l4GGsN+AtRYu/8q818LvNx2JTJ0mvHUCvoKS0ny7c?=
 =?us-ascii?Q?/rtSdsIFujks64v+FpIhmlxbgA/n8fPjgbxdaNX/WzJ+ugJa7rFgKyUCcPn3?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E477183364C00149894A3FD385A2371A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Oew4vDGxM9Y4aLCbt782O8MLTFDa8zIkip+NCKnenyHHV9LmFJOpoW8MzHoZcty+QYm52lLZYu3iTVFzsq72DDNFehl3ZqAZLdCMFl4G6hEu6zFK6mlJ19+kMJlPuU93YW3cU2hak4WRW3vBPvTzpHZjt+GYjY7DhlpHeKCjvUp64t/qZeM+UzVkold4naxLO8XcWC7/a7RZE9z1wUYvmKm4z1lVhFppSa8yo2nKqfFDNSNePKTvpXvcwhMp8P1znrPCNuNljRjmFeQFUZsStrlHleN5rafHEg//SXfTT/QbLpAA9ProBvufSvdW4mf0U1HJu5uN+hIOsDhALVOC8S6EP5dh5leGEHn2U24vbd+Cbi3ZX2AkT8SQJntSYPuDvUJeF4USjR19U9NUDPrg628GuSoHRUS2ywaSHkeZgvJ5pB52CGCpJ6T33IdSWa+KDQTkcqVQ9Z+NDMlA6zI4g6vVmx+AYCNXhTyMHj9v7v7kXcOHnOA0BohNIV7OHSvstkt+k46M0BPtRsFm/R4Zk7ynkJrYDh7myIvjgynFiSc8j2T5E2h6WXOn9VxOlAyd6e/4I+htN34Ry5VwTiIjJ0gvZ8iWeUqUeFKRFk6jwGiNYedgy2mf7qtfor1K3t4KttSue+Ald/TREFr1Dz5Y2XeRbiyjD2S4Sc+eGMeKQ88HujZ7APixMbR4brK2jslxhgnQqcyl1DreeTriTvipoENGZZ4zL6A/deFgXAUhZK2Rb9BHCnwchfyvTfEHXLZ9+eMH7fLilYlSBjVdkxTrOguhUC7vYo70gZUCWT1p2TXi67KSM+alm4T1Ki8QYuKP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bc3248-9359-46ab-2a36-08db6694cc98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 13:49:07.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlchxeLf+08JwFfgICeGOjkDCBdpplXBIn/vkApmMceHOZ5wEoI2rJO2AVLEikadZhrSJX0O9ECB7LJHrAuREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_10,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=636 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060117
X-Proofpoint-GUID: U-fJlfUlcqyoQPeYl4x4p_37ECYw0LEv
X-Proofpoint-ORIG-GUID: U-fJlfUlcqyoQPeYl4x4p_37ECYw0LEv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

This WARN popped up on an NFS server I was testing via TCP
(IP over IB on a CX-5 VPI NIC)

There did not seem to be any other ill effects, but since
this appears to indicate an unexpected memory overwrite,
I am reporting it.

memcpy: detected field-spanning write (size 56) of single field "eseg->inli=
ne_hdr.start" at drivers/infiniband/hw/mlx5/wr.c:81 (size 2)
WARNING: CPU: 2 PID: 1217 at drivers/infiniband/hw/mlx5/wr.c:81 mlx5_ib_pos=
t_send+0x59d/0x867 [mlx5_ib]
Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs rfkill rpcrdma rd=
ma_ucm ib_srpt ib_isert ib_umad iscsi_target_mod ib_iser ib_ipoib li>
CPU: 2 PID: 1217 Comm: nfsd Not tainted 6.4.0-rc4-00025-gf900df712a57 #1
Hardware name: Supermicro Super Server/X10SRL-F, BIOS 3.3 10/28/2020
RIP: 0010:mlx5_ib_post_send+0x59d/0x867 [mlx5_ib]
Code: 32 b9 02 00 00 00 48 c7 c2 9e e8 a2 c0 48 89 c6 48 c7 c7 e3 e8 a2 c0 =
4c 89 8d 70 ff ff ff c6 05 b8 f5 00 00 01 e8 19 3a 6f e5 <0f> 0b 4c 8b 8d 7=
0 ff ff ff 48 8b 7d 90 48 8b b5 78 ff ff ff 4c 89
RSP: 0018:ffffa7444d88b6f8 EFLAGS: 00010086
RAX: 0000000000000087 RBX: ffff92f446dd8000 RCX: 0000000000000027
RDX: 0000000000000027 RSI: ffffa7444d88b5d0 RDI: ffff93037fd1c6c0
RBP: ffffa7444d88b788 R08: 0000000000000000 R09: ffffa744418e0020
R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffff92f44a488748
R13: 0000000000000038 R14: ffffa7444d88b7c0 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff93037fd00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555556bf640 CR3: 000000010b968005 CR4: 00000000001706e0
Call Trace:
 <TASK>
 ? show_regs+0x5d/0x64
 ? mlx5_ib_post_send+0x59d/0x867 [mlx5_ib]
 ? __warn+0xbf/0x13c
 ? report_bug+0xfc/0x16b
 ? mlx5_ib_post_send+0x59d/0x867 [mlx5_ib]
 ? handle_bug+0x45/0x74
 ? exc_invalid_op+0x18/0x6b
 ? asm_exc_invalid_op+0x1b/0x20
 ? mlx5_ib_post_send+0x59d/0x867 [mlx5_ib]
 ? mlx5_ib_post_send+0x59d/0x867 [mlx5_ib]
 mlx5_ib_post_send_nodrain+0xb/0x11 [mlx5_ib]
 ipoib_send+0x424/0x4e0 [ib_ipoib]
 ipoib_start_xmit+0x4c3/0x57d [ib_ipoib]
 ? netif_skb_features+0x1a1/0x1f2
 netdev_start_xmit+0x1f/0x41
 dev_hard_start_xmit+0xb7/0x14c
 sch_direct_xmit+0xd5/0x219
 __dev_queue_xmit+0x59a/0x7b8
 ? xfs_vn_update_time+0x156/0x167 [xfs]
 ? push_pseudo_header+0x17/0x2b [ib_ipoib]
 ? ipoib_hard_header+0x37/0x46 [ib_ipoib]
 neigh_connected_output+0x9b/0xb7
 ip_finish_output2+0x39e/0x3f5
 __ip_finish_output+0x125/0x139
 ip_finish_output+0x98/0xb8
 ip_output+0x5b/0x91
 dst_output+0x2c/0x39
 ip_local_out+0x34/0x3a

....


--
Chuck Lever


