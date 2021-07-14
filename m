Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5FD3C8E71
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhGNTrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jul 2021 15:47:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62552 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237893AbhGNTqr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Jul 2021 15:46:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EJfZZj000623;
        Wed, 14 Jul 2021 19:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S+0B1b0TvKBjukXCqkq6oqH1sZf4imlj/0UjXBesYok=;
 b=WDrRqTO9Gbb+LfNooO8LbRxrMQpL5AfYDewzLYaR/NuftffWDLcXBypUQgTD1OHzqdk/
 O0qaurt7cG0YxCGkomIGAgNrloudsBinSMlIojRDx3+5Jzws2vzycYY0AwONzqwJjjDQ
 RlxPzxzp6RFUklkbubUmuCLVT8+QED9pNkyd1/s/MSGtTXvV3xwfTTdeni+5nk8gej4W
 Ur/B4r8wF7QakdqnKPh5lyDeC79G+4tF3o/2VXT6B89ifA7Sk7hShBz1wHBA35M4QFKW
 brr+uKXaoNF9wllQeUZpGTuYEy0yd2T2PM7/IusOp/DwlFjik5IAdCapEUCPv7dNWPyg 1A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=S+0B1b0TvKBjukXCqkq6oqH1sZf4imlj/0UjXBesYok=;
 b=f0YeaW2BdUPyW8R62iRwEso9EnkBO5tkLchJi6NfhhLTTnF/6wA9/O4cSaJEIWZB5oKQ
 1+dQUnG1/S3tTeDE5ekVpJsvLr/BhvEQuUMTh2Vg4hDeGa0ehg2LpRW7RfrSFPPphiCH
 I6C8HQTNMrtcBhhgzg2Sx+Vb36c7iP3gI01M2P3G3WnZpSoC3CVi2PcL7OAk3bZ8x3+T
 imWp74ApCAF842VD+hyWSYjE35MI9yQaxy/Sd5p/iQ75LD+pJHAKwVuh5f8aFAK4qvNL
 ihV6LNZ15fJqpF1AQTklGObq9iAV7KkzbbWiAAB6cP0yYbjz+XDva+F727KDssrE1wNO OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39suk8sf0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 19:43:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16EJexWZ023348;
        Wed, 14 Jul 2021 19:43:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 39qyd1cfbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 19:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvPMv0FUKLD3ic8DzyibWFd8WK0Lq3zEZ5LIHC1EnJQJS0eouSOrZou16to4htw2+x/GiqXgOfplO71DK8ITxFJm2g77eC6ZlJtPzO/6a4Z7OygS0sVhPOcR0aL1U7w17L3YvOQlM53XHgrFF2s1OUrRTTbCNVqmlI075X+bFbZaN38Ef624Bc6f3ZwCdcnSa4dr3PNC83G9u5dImHyOeX8PqExyrQ4UF3/VkG2qzfZWXdF6idUBQz2SGt2W4CZ2K20HB1QHHoqTDgWz8aUFhdmxUxlKZlEOK12HERj/ImUnHH+/BZK8ED90cgXL2xgAU1co4t4HOO3pOwtuCw4fwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+0B1b0TvKBjukXCqkq6oqH1sZf4imlj/0UjXBesYok=;
 b=Y3XcCHFpmL5BjlvTWmKt6t0OQJ69KXJjBA8j/pqn5neM2RbjBhhIHnKUbR752ySw+OGBsQ379pXd5DosZDZHw7gjp8/iSRjv3HDH+WiQ7/LLiZDzY8TLYSHiNN2BB2sNa673FG8omwVpaPiLKm+LbBArXxIHHsAHNZ21GeWkvl8wTe6r+G5FUaTg7U6HQQ1WSTBS1ladHGp57Diy3fRAXMzn6piRKl6e9tBy2BxGHtNubP2QxFtDwo1SPDOZVydl0mVD90RGkntc34yEDjSKNW7p2qw4Yr1aLX6sdIe4Ds0vkwZqb57SR9IGSnEcFwtmEvvvNrBqOpt9X2nO6e5AIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+0B1b0TvKBjukXCqkq6oqH1sZf4imlj/0UjXBesYok=;
 b=AI5lnqGZucEE1efNGRd0jgxRwot8AtfmEX4d0QwvivDk7/lhCbShmDKB2hy033gg6SqUnkBEtA+jx5miUgNaU9OIdmdZFPDNKXo/A17B1rE+2kTlelR80uXRe3YRM0LArRiUj7ZeSvZoEBURnC/sKoXUOCP6XpDHkhqSagcCjlA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 19:43:50 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 19:43:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: NFS dmesg errors in 5.14-rc1
Thread-Topic: NFS dmesg errors in 5.14-rc1
Thread-Index: Add4zo3mZX7NdJahRUuk4Wkzu3kNtwAGgJsA
Date:   Wed, 14 Jul 2021 19:43:49 +0000
Message-ID: <9875E135-B13D-45C1-8FEE-44215C961C92@oracle.com>
References: <CH0PR01MB7153D36F6E35AF2239C763C0F2139@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153D36F6E35AF2239C763C0F2139@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 211d24fe-ed79-4196-3f25-08d946ffb3a1
x-ms-traffictypediagnostic: BY5PR10MB4147:
x-microsoft-antispam-prvs: <BY5PR10MB4147A0A02C9A01FF8A0DB40293139@BY5PR10MB4147.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FI16G5obNZ5SXst/PCOJZLVlIvGsDKT6WSHDiwsnYrNi05x9sfrRG7/SkD2456ItNlGWe41gIcjFHd7+IhBeXLNkl/oiJMuD+moRdQ6pjNU7qHnvTG5yvEkTiEiU8h0tvSVwQc74KmKDfG7I+NCRLZ10zlnC1Yl+BedrPpsHH1AgTbOK9okDJCOKKeHHCBrMyomFLbLA71qcHO6RfSLUu57NtKMLlh1VOCqekzKp29OPw3vuxTO78p7cAj1oq4s7ebIGSjz4hfkQFvxaexx7stxxMetDwWNvcvadgpa7VvCIKjGAG03NYcDDaMyGKUENfD/YGhUl2H2nItNxt7tbVkacP7b/rvu1sAj90o2YZ/VY7BF4gP/QyDAwj7PnSdCihKHzwiRvGD+GWg98Ip6TXNzhjNA+LJkf5GUJbsSFr8UJqg5G2D86kRUq70tNDQyvca/MMeqGA7V04u6oD+Vucv1Yg06eEi4FAh83697wyvAH8YNKQL0wic1HebNbuGgrXg9VWPKXjdKx8CzbMTfmY3jBc2e1lb5WzWzlNOXybO3F8IDS+Ibkqo80Jr8k6qC0VgOFYrRo8YY1QDsr2sCoStn9i2klMLeYUQm+rM57PRYlA2wpEKFCys5wWM2O9YSo1R62aOyVlBP+I2tTaBsJx04jy4u5AEXOE/ZkHhmKwOoSkeM4glcCjHcJOtbraw+tGTAghQ4tdjP8qj/blrD4aJUiomwI7wFTvuDj0ofDHBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(346002)(396003)(316002)(122000001)(2906002)(38100700002)(6916009)(5660300002)(53546011)(6506007)(8936002)(6512007)(45080400002)(6486002)(478600001)(36756003)(33656002)(2616005)(26005)(66946007)(83380400001)(76116006)(91956017)(66446008)(71200400001)(186003)(8676002)(64756008)(66476007)(4326008)(86362001)(66556008)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Q9LoSW27BHo9v+bx3m3ymuSPcn0nKRyzWVoeX1nv6poG5/rq2CJ29CoNigl?=
 =?us-ascii?Q?556fbMybphUCkS3EzMHWFietJSgcfIRCZ/e5L1N6q+MyBJjmUPzz9eUx8qS/?=
 =?us-ascii?Q?PJdNoRS+37nU+WWJ3wU/musLZCRK/vWIq2I22j69yvgHyxHerXIIQpNFl9HM?=
 =?us-ascii?Q?V73rBs0HrZVvz/iVI7VUFo2GcHrY4tb2HX1Apq4LOO2K2q9QMRQJbDcARXYp?=
 =?us-ascii?Q?5T5JFOmDXQO45+7YUAxR091hVsO0VFf0VdhK6Gk77y61PeogWJXPiIt/C9ED?=
 =?us-ascii?Q?GXBLUr9zWQWCnKDgWdl7sF00+UUGPNv7F1eQ4OcYDr8i0t051XY956Zkzek4?=
 =?us-ascii?Q?9a9ffp39Io9c0oWeTWj61qD4qg4RKyht6D6gzqtQNdUZHeULwmy7G1wljnFh?=
 =?us-ascii?Q?NeAWAEh/49c31ELeScCZSTw9Kx3fr/2l2Lu4d378dL/gga6FxI8quH5O86EZ?=
 =?us-ascii?Q?I4ZmFb7KeWL+oMu3KiyYOnUG24iz25Ay2TgVXIy0JOPDULRVFmhBlSMNHCZX?=
 =?us-ascii?Q?AkCBD7ohHi5eVK3XGyp46jIjr0ZzFTKjWT0Vq4mjfzqOcxWPjUYSyqjwThCA?=
 =?us-ascii?Q?t0kIGZ3RmfX7rgs0vd1MWV+QnVyAj4lPkpNsSQfti+HQgCxzRS6k2rQItWQ+?=
 =?us-ascii?Q?0QdXhZtpfhl5Hy5V3N/VyX5ZEwhf2WYNpFwgtPgqsBHSSgzjAdl2QZpMwvba?=
 =?us-ascii?Q?PT7RaaAMWx14+56dtGd4eC1t8gTHbhfGCduq62rVX50dxYurDLeoM7Lz0VML?=
 =?us-ascii?Q?3bETBKePGk0Ul2K5KV0tEEJk1DGxwHzxLqzW6v9QZ7ioXIxCAu8vy0WjiDB2?=
 =?us-ascii?Q?Lytu3KfMax2/Jf8ERv01GI3dvdsS0b9oBRbWTPCmLfgI6XXyr57afoAWM3/g?=
 =?us-ascii?Q?CsBCHtKQCeUeSW5/n25sVSUqm1uUp4k1HyzaeSdBUSKE7R5gfauxRF9xVgcx?=
 =?us-ascii?Q?Jz9Cnefi5Eb0xtEo4ngfxwOcaABFrMTUWWTbIRLNDDpIrGubJhlr4w3XjPKV?=
 =?us-ascii?Q?vu+QfMAsAFkwxWRrpSrHJZH9xvJ/Dmbq3p/A2jH8621O4ES2aj2m8PPHqKE8?=
 =?us-ascii?Q?gKZL1A7XVv45VwqPoNJT/6hGEgGvJ0u5tmbVHrGC2QtcCUSgF9LZTruUFAQ/?=
 =?us-ascii?Q?ko26sMA+DCBWHpNK0tjCCbd/3t1/wpuNFiYfmd75UIAft0G/lKUJULgjrz8B?=
 =?us-ascii?Q?ptuTQaAo5mhJPo1x4ejrmubxrRQRQdt8/h4OU5hfatagkMFGKq1Syr3N9x30?=
 =?us-ascii?Q?axv1Kdshe5t05UNFi2I1P6RB+ElJ8uPmOaC9eTXY7y0PLu8bFxGsMfwIKaAo?=
 =?us-ascii?Q?lnzQDcVHEiS0UQB1Nw1KUffz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A66F7B0EFEF5642BA7B90491A5C734C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211d24fe-ed79-4196-3f25-08d946ffb3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 19:43:49.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9TU4Sqs6WIvOr1vuPolkf7YKqCY6oUxrc4Gyo/UdMPZuB8vVoob4Bf7zvHHph8Ogbv+83uoRQNcevNZpdl5Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140116
X-Proofpoint-ORIG-GUID: zaVWdn9ufedOv7dvpTWCReXxME7lpNYt
X-Proofpoint-GUID: zaVWdn9ufedOv7dvpTWCReXxME7lpNYt
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Mike-

> On Jul 14, 2021, at 12:40 PM, Marciniszyn, Mike <mike.marciniszyn@corneli=
snetworks.com> wrote:
>=20
> Chuck,
>=20
> We are now seeing this in the first RC:
>=20
>=20
> [31868.644165] ------------[ cut here ]------------
> [31868.650059] failed to drain recv queue: -22
> [31868.655191] WARNING: CPU: 32 PID: 559 at drivers/infiniband/core/verbs=
.c:2738 __ib_drain_rq+0x163/0x1a0 [ib_core]
> [31868.657234] ------------[ cut here ]------------
> [31868.667133] Modules linked in: nfsv3
> [31868.672832] failed to drain send queue: -22
> [31868.677279]  nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nf=
s lockd grace fscache netfs tcp_diag udp_diag raw_diag inet_diag rfkill ib_=
isert iscsi_target_mod target_core_mod rpcrdma ib_iser rdma_ucm opa_vnic rd=
ma_cm ib_umad libiscsi ib_ipoib scsi_transport_iscsi ib_cm iw_cm sunrpc hfi=
1 mgag200 intel_rapl_msr intel_rapl_common drm_kms_helper sb_edac syscopyar=
ea rdmavt x86_pkg_temp_thermal sysfillrect intel_powerclamp ipmi_si ib_uver=
bs sysimgblt coretemp fb_sys_fops cec ipmi_devintf drm crct10dif_pclmul crc=
32_pclmul iTCO_wdt iTCO_vendor_support ghash_clmulni_intel ib_core mei_me r=
apl intel_cstate mei lpc_ich mxm_wmi i2c_i801
> [31868.682425] WARNING: CPU: 65 PID: 608575 at drivers/infiniband/core/ve=
rbs.c:2705 __ib_drain_sq+0x14d/0x190 [ib_core]

The above warnings tell us ib_modify_qp() is returning -EINVAL,
twice in a row. ib_drain_qp() is not able to put the QP in the
ERR state, so it didn't try to post the drain sentinels.


> On the same tests, the mount command fails with a connection refused...
>=20
> Any ideas on this?
>=20
> 5.13.1 (the first 5.13.y release) tests fine.

There is exactly one change to the client components in
net/sunrpc/xprtrdma/ in v5.14-rc1:

  e86be3a04bc4 ("SUNRPC: More fixes for backlog congestion")

Based on these two facts, my first inclination is that this is
a problem with the verbs provider, not with rpcrdma.ko.

Let's collect a little more information. Enable tracing on
your client before trying your test again:

 # trace-cmd record -e sunrpc -e rpcrdma -e rdma_core -e rdma_cma

When the test fails, ^C the trace-cmd, and have a look at the
trace.dat file (and/or, send it to me).


--
Chuck Lever



