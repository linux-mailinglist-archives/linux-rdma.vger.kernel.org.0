Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF333F7B5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhCQR7a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 13:59:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhCQR7W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Mar 2021 13:59:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HFBOEB036200
        for <linux-rdma@vger.kernel.org>; Wed, 17 Mar 2021 15:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AvrW0+zWQIyg7yUK4bCx9OZHEMAEOrTyHi04BZh3KyA=;
 b=w4lQT1rA+eiuyV/nb6pq/b5tAVpLoriEaidhtKkBmhHhUtzydu7VQczroPWa/lwtqQmU
 ka6u2XAdYB9SrFIlZ+sLl2PBd1k6wFcBB3XBp6BSgtmkRDndm5BTOoCxNLDrdbS/vz73
 5otnkfyfxlh944wZnhZEhMB0WXYnbCEtZyuhxHgcKHiNKqIhuTb5RLtflVNXE6CIgjO8
 HB7PwGJBHAPLWGaPtMQxB8NeOcxGIYhL+9JtSAJpHRTAcYkI1Zx95pDt0QNkOQKEc3d7
 9jDlpsTvbxnW3g9h/jXYVuVWFjT/eOvZPmEayXA02GyyZdcTgyBsgLPnHahjvQUE4p5u qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbmce97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 17 Mar 2021 15:14:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HFA21K033918
        for <linux-rdma@vger.kernel.org>; Wed, 17 Mar 2021 15:14:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3797b1mtrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 17 Mar 2021 15:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiNq8ND+Y3Bds42EPifoYw15bxSyp0IzOb2//wLlO48CFzku7+EVzut5bSO2XDZ8O+FBFg1xVbGFWuEw3oWZTnOJYeKmC529oc3MJQ2OQQrSGVLB3GAtvjR4A4JIj4o/E1mTjR0hfQwlGxow4Cur8knOmeck5uLicEY9yriXNX70kO+bdWgNwYp6SVK5mgB704qH5apw7DM/pg/5L9r/x7PO02dLDCoa04SUdsCx1uXY0AVd27dfxpNrnTWWgJHirguaMB+mTvDTxFKG67MSRvZLMeRoIDQ6jORllVzxGs2MRlZX3OYwTAB6YerOtVEVyUe5LHhhBkxdgVYiUrsAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvrW0+zWQIyg7yUK4bCx9OZHEMAEOrTyHi04BZh3KyA=;
 b=UIodLkpUJwiJx2Ijz10nII0a3cVPXTZm/6XmMYnIlPBQMdXxMvyBm+m3dmExTHQUiWGEy/yGhMtYTHC4OPpZi6Ji72r1n9NWR6iFAGz2HIM4sT3R3VZBPdeyRCqnhTSfWDmx5DeyLCm7C8J/uGuFG6yVPGcT8L6WcP2Xn9qtuQhwETjpULnYsmCdh2gkoA8hZadZ6BYTj9tUmzJ8VhgBG2bRdOMDqR0QCNomPuGZM089SBERpiUtpDCf84EFRF8cjcZlYIzv20N4m0u5O/V+Dahz9WDWZJOArjbp02jXk8zAoHvfo53ZDNGtjxZcfBqbIcdsMl5wWtqZi/pngm7kQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvrW0+zWQIyg7yUK4bCx9OZHEMAEOrTyHi04BZh3KyA=;
 b=PP4WzZzH1eTIljrTL1ifczK5smAJ6DmTjjo0AnihNJil/KxF3XcmdkwRadlRu5zs254Jh4Cg1R2YK3vvCsTe1Z6HXov7T47uk10xGPYIVw7WhCSI6pVsUSepxBEvaJQ25JgFQ+lbwrgBie9jJC1z9YbJe3Q8cZpTuivKK7JUs28=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 15:14:51 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 15:14:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: FastLinQ: possible duplicate flush of FastReg and LocalInv
Thread-Topic: FastLinQ: possible duplicate flush of FastReg and LocalInv
Thread-Index: AQHXGp6rQmS73ds8r02HG2jW0ooLiaqIS08A
Date:   Wed, 17 Mar 2021 15:14:51 +0000
Message-ID: <039DFCA1-84BE-4043-8136-423055A12796@oracle.com>
References: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
In-Reply-To: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786f97f3-84f1-41a4-2912-08d8e9576977
x-ms-traffictypediagnostic: SJ0PR10MB4637:
x-microsoft-antispam-prvs: <SJ0PR10MB4637FE08106AB38AF9D467E7936A9@SJ0PR10MB4637.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVHWgzOnmOE+bOReu9jNUqU7mcuvIWc8HFV6sG6gOeMmZ1iX8jJqNYh+SE0lJPEnp9wqdkeCPax+dFAy5DfAGdwHHXw8h0n7VccYtb7FQlvakoPkqrELnV6cfxkNeA0d7V34Js9SQ8IgO5dolRV9vVEdZ6GA5E+rK2VOIiC1gHHzLC5vf+PRmDv3AsfSxkOBnb5Do4pLg43IOn1zZd3NQs/yVaEn6Zn4QnuZ+hHr4FgCOPJyT4abaOnWn/Dvi34rMPp0pOG7rLFz5f2zogM4inK9Uina7ocAVK+APuJtPav/Jj2/ZZoEFbzcv3XzrpZ1ClpL8ECMXtraytzSXU0gNs1s3y/uZK9u80W1R1oS8x5pRar5H56BAjbhM3qHysaqbbVu18jQ2HkVhUflXoNUJtGgPihpt569RnJZ2+BYDciCip1Va1eQXJmrNwlvHKSz0Mi6sW1/SnroF1OoCLJaY5OodXW8wJaA43emZCjkUs0k6HPeR92j3LfON4v3IPk7JOHpB/ciCC88KfNnTZai3r9Fc+gzSJUXHoDf0wJ2IfNirtpUHWBYsV9MdDUotw6ztiSwEu64bn4IfivNy6eMzy5dQLHoj4kXid+8QvVlQ6Goy3Q6S4FaUxGfp3E7w1tB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(8936002)(36756003)(6916009)(5660300002)(26005)(186003)(71200400001)(33656002)(2906002)(53546011)(8676002)(6486002)(66946007)(83380400001)(91956017)(2616005)(6506007)(316002)(86362001)(478600001)(66476007)(64756008)(6512007)(66556008)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EVsVoesWEMtGo+cJ6GoNxcJQ4NDvTkYH5ulBD1mTCvez0wQ6/Pv67CMjot9M?=
 =?us-ascii?Q?fwPF/YhLzP0kjtmjRvaBLAhvmp5DV39j2qs5zTWmOXkZGeuAxKK+SFomkEH4?=
 =?us-ascii?Q?2O1T6CcxPbNr4F9/0dyEuma5+hSl4dJF+nsdENy6gxlkgJFIlBb/kTfuCk2V?=
 =?us-ascii?Q?tURdcWzOsDoei4bnNwFCWXL3aqg2NnfQi/8gHjY0bLFCSLblfVP3vnG+Fpt0?=
 =?us-ascii?Q?YYqtmiOpCY1bRQqF3A18BhR/lEm1vBC34wvq/Mn/4eDO8QR4srphlIRUJRvy?=
 =?us-ascii?Q?uCUbsXXrcuFB7/2Z2jh2mk0xn5F+WLBonVmOCT95vEme9AJpuvgHqd1bOLO9?=
 =?us-ascii?Q?sasJiE0XtNHQUHIAp+VjSnlctYOREu6R85cIV6pRz2BH7sMqaVnM6ZEv0hp1?=
 =?us-ascii?Q?ETzZqoAfHiXG0Q02EhrnRwd5atrbinvxI7TBBTRbykkkuZoCR3lWd5cNo8Y1?=
 =?us-ascii?Q?xuSb6H+r7/OA4VssP7LSdoeiy9ZicDnVZmlqZuyzCpK6J0TpKdYaRddXzVtL?=
 =?us-ascii?Q?LELzUnu/LdnfyGtqeJpmHWJ/4M2IbBGzpv/ebWirPHO4rKgIgnnn7on4MpQk?=
 =?us-ascii?Q?cxE5FnUUKKQv4CrooIAeRuBrXoaG0SuVzafuVwurozfe1/ZV7U2zPM+nCtKi?=
 =?us-ascii?Q?hZH9MhhAX/TqzQ5l1pZvvcGq4st/MvMQa1kxmi6lHmxepUNww/GFwETyyn61?=
 =?us-ascii?Q?onl5iDNos1FpwoMeGjqcIDkN6VHRqPbMmlhSagXXXTWlrxefmSS9R9OLmgTQ?=
 =?us-ascii?Q?7anFvEdz7GwiT5UGM4hfZGFgclN7wpl8xCPVK33NUA4Hw6XDM57BVOApFW+Y?=
 =?us-ascii?Q?ygD9CuoiIjLSsMK9SVn1CE7l35Pcvn2KK6lgBEmxPJ712G3vOC79Qk6CddGg?=
 =?us-ascii?Q?mrwluKCVK5nqzw78EZjySYY5SYHkqu1/Z5ZzB7MXixLJwwn4LWuwNjXhy1i8?=
 =?us-ascii?Q?93O6Yrz5Xvq/QoJCuXM9Ikw/f9Z83EQrmG0RJp0mrqios3XNxrdYRW6Tj0+d?=
 =?us-ascii?Q?j37ps35/DDZ3+EKGTmA6Tfc6qMNfatP7pvHXqfxVblW+aS0XKGen8Q042Ygq?=
 =?us-ascii?Q?1nHNnxsJOnLJxDhk8cjMcd3v7aebeyionoFSLeQEoxdQ/NoxoW9OLwl09QYz?=
 =?us-ascii?Q?wpN6UHU0t3yO+2G7bauMu5GmU1ofN5nHYxhjwhYoF1MrSQAZaiIEG6ETrHBL?=
 =?us-ascii?Q?kb67mJeMTZhqdd44s95uqrWZ6eu4fuXf97/DgCjG27RyAue0gq3SBxK6enb7?=
 =?us-ascii?Q?ZWTPLLYzP6L9UxFZZEMC7i0dE4DEKznpDKiwuP5LToCl9Z0NSVXxr26w3GQH?=
 =?us-ascii?Q?metGWQWt7rIKDnlSevQ8VtDD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA5766D6DB40BB46B9DA6C83E7F30AE6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786f97f3-84f1-41a4-2912-08d8e9576977
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 15:14:51.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OS660XWWb4780BRA4eAI0GfZ+OftJuh3H2snSc6z0rA9/2hqxMGvr4+eYf9WQWLm2S9TJFID/kb6mxO24QfZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170111
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Mar 16, 2021, at 3:58 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
> Hi-
>=20
> I've been trying to track down some crashes when running NFS/RDMA
> tests over FastLinQ devices in iWARP mode. To make it stressful,
> I've enabled disconnect injection, where rpcrdma injects a
> connection disconnect every so often.
>=20
> As part of a disconnect event, the Receive and Send queues are
> drained. Sometimes I see a duplicate flush for one or more of
> memory registration ops. This is not a big deal for FastReq
> because its completion handler is basically a no-op.
>=20
> But for LocalInv this is a problem. On a flushed completion, the
> MR is destroyed. If the completion occurs again, of course, all
> kinds of badness happens because we're DMA-unmapping twice,
> touching memory that has already been freed, and deleting from a
> list_head that is poisonous.
>=20
> The last straw is that wc_localinv_done calls the generic RPC layer
> to indicate that an RPC Reply is ready. The duplicate flush
> dereferences one or more NULL pointers.

So this looked to me like a Queue wrap. After sleeping on it, I
decided to try disabling xprtrdma's Send signal batching. Setting
ep_send_batch to zero causes every Send WR to be signaled, and
that makes the problem go away.

This is a little surprising. Every LocalInv chain is signaled. The
only possible accounting error might be that ep_send_count does
not count FastReg WRs, which are always unsignaled.

More investigation needed.


> Doesn't the verbs API contract stipulate that every posted WR gets
> exactly one completion? I don't see this behavior with other
> providers.
>=20
> Thanks for any advice.


--
Chuck Lever



