Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17E7563706
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGAPhV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiGAPhS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 11:37:18 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF539819
        for <linux-rdma@vger.kernel.org>; Fri,  1 Jul 2022 08:37:17 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261DT3Oo009375;
        Fri, 1 Jul 2022 15:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=2AwotDh1GKxxX0GahhGSIcZo0asV9HUWlCCPCOmrdok=;
 b=KrT7AnePnZA4ouvuoxCT7pu2bahj548L7wkrcTC8NzKeBOPEn1ZIBDVCh3i+6z+mHI2D
 X5qCvy8ExXpV6lWUrq4ugSgDG+Q2DxRMd8wKczNVELRDG1xzs3a8TO7QksVxzkrxHLCO
 Xypw7vTBJCRcVRSoIjvfQ7TvkfTBMDrFcftJpkEm8Y1Le/LvpjbS69JLyDrUdLKtO+Mr
 8vNPb8GQGBYhciz3jM66T4eGKgJljxdaL0XZBIqDrsdLepASB0SUSOswiusDwvNT6ZXY
 wDa5AFjBFoWyQs0cj/SKvBPfrmRjq6ycPXG5TjKybx27FjXmtwLK4gp7L6tfhTKs71Cl Lw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3h21uj96ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 15:37:15 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9F4DE800197;
        Fri,  1 Jul 2022 15:37:14 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 1 Jul 2022 03:36:33 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 1 Jul 2022 03:36:33 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 1 Jul 2022 15:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/lIBVyvr5V1VvvfDW4X1B9gQq8ABiFhYJQHCCkwC5fG2AYX+lBK+xsRUqEgfoOSC2INzWUadOZDdRgdV4lfEBUZhxCDJV0vWubNiKEoxxdmDmNrEz82rdnLpQw50/9X0uimOLJJebJavwEegtDjmqXl7kigvvfWGvmlMNYDL3BnmMzVdflsPELSgla5p1sFNEOW6HBv0zDSW5x5fW7qSLyD4Or2B/u/SDhNoCcxmSx91Z2E+l+cmBuKiKnzcdaDstPuQ/HpPNY06nDSfk49R7Jxq9lal5M1kcOaTHYgYkBbyoFvsFkjm2lxy1Mahkk+yBevAD+kux8OOS1gXEifYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AwotDh1GKxxX0GahhGSIcZo0asV9HUWlCCPCOmrdok=;
 b=Xy/n0GOAGGX/LyTUmgeQxOhPQGHY+L/hVVL15+dJPjPyeJPe96pDMYAa+0l+b4Rrvip1rfa85Ba/sHzSnAGUNr/zlMnjy358oH8cuHxRr5JTzIRJde1XF/SNVgyvxUgEJRJQH14uXOLw6C9ok7fvjLHQ3T/mrpi1Vm9Z7K/B5J577uOgSZc50FDV7TlwAX+tc/ldqY8HBzlLG06xGK38zLZlgUFKWSgFWaLwEVYDgawomB8UXzUZ0MkIRSlXkSLiSGuuJlwb95efyg0gBDH6bb3sAPmb3VDMgL3pOj4iWp5bbrMmnXwzAxBqpKWTBcXFaM5Yb6oU5kzTv/RzwHR2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB3169.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 15:36:32 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 15:36:32 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        "Zago, Frank" <frank.zago@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/rxe: Fix deadlock in rxe_do_local_ops()
Thread-Topic: [PATCH] RDMA/rxe: Fix deadlock in rxe_do_local_ops()
Thread-Index: AQHYjN1XkkQ1LZ3oz0uOahdoEFciNK1ppuTQ
Date:   Fri, 1 Jul 2022 15:36:32 +0000
Message-ID: <MW4PR84MB2307E87A31EAB55AE0090831BCBD9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220523223251.15350-1-rpearsonhpe@gmail.com>
 <20220630235752.GA1083417@nvidia.com>
In-Reply-To: <20220630235752.GA1083417@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3161cac6-9e64-43b7-910c-08da5b7779a2
x-ms-traffictypediagnostic: MW4PR84MB3169:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yue8pW7UAlzBBVAai+01lIwbudjYWegG2vQvPQmxZ9t4Y1odE2V9uEQASsAjagCaJTS8mOHmAJGT9HUHKaKIfzIILJKFVGnGe54ZnxyczxQ7j4ecqVafaWfxOBpoiymEIi61wu4vWvlkmdikpGArmeMq1aDGSITT4xg1vHa4+c3MNJGECvXLZvh5hVq9yaM+b/3SLF7P1C7j65umNipFgsS3GXmXAx7Nt58NssLVvbVTLogrg8lIO+6pUMJR+oU8YtcIHB2cNpPfuDeEpl+71rQpi9/lGP3JQlklQBeo8dyrUNhl8pzQfQW542aTFdpSTWJusIzBMyCrT+Dd3WoR7bbKhn8pu1UggFeBZT6SUqOklO64D5ldw12XnCpqYiH3mEv9rdoyvbIbSiBNc9hbkKQXsOI1x4zKPuNIAAM/b65EqT/Uoj4530BRxuI4AujW81wPlnR+z6YTT/lmwY2QPHGqvRP2gesAKM8Hn8HdZuVMJ78xKvupM5rGRe7zjDPfmQgbC9G6cj+jv8PyoPKmM//2zZeBWXSfBRxA+4vMz9PJ4Gwq6xvCSO3JfOYndkqQ1wtPm2jvOIZ+pX3mNN6BRdNvwpbNOJH/vkLTaDHRBVD2w9RAra0PeuM5nh+BKgTjmj6wGclEJC5tG+TjJRnvkOEe8eJJuBBoS8147ntszR1gvPfa72ufaXU2GuFdfLfDeD9hd7ptc4HrR5PCku2VDq0VcD11rvSCmEz80WkvwD1614VUUSa7sfb9iXBB44or5jPeJR+kyzOWxYSzBQ17s9ltJgLXifkppPPKjN0/eODmaIE3mSwU4Gsd3lKRZvhp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(346002)(366004)(39860400002)(122000001)(55016003)(83380400001)(7696005)(71200400001)(64756008)(66946007)(66556008)(5660300002)(76116006)(8676002)(2906002)(66446008)(4326008)(26005)(9686003)(86362001)(53546011)(8936002)(33656002)(66476007)(54906003)(38070700005)(38100700002)(316002)(110136005)(478600001)(186003)(6506007)(41300700001)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vFOSQm24B8aE9KbxXdMHhzz44NsCAk5M4kK1ZM8s1UE9NgKjjjFYvSt/IQkV?=
 =?us-ascii?Q?9U0Jlqn4+AHKPRFOrmuHecc/GHB8r750yGBFc8InxTQWCUKBcGSm+Id3xX6W?=
 =?us-ascii?Q?kU0KO/8ekwmqAadBdPaEtQTHSavVnyOEB9854DAySgiiJHsZVAZcrPToEhUO?=
 =?us-ascii?Q?tdC74NcigVfhGmJSDYfH7pa+dAN3gn8WJrufUPjVrw2fuG//9lV2MFRo9Ti/?=
 =?us-ascii?Q?oHmQaXmE66wDZsaf7kjPwj3UBLRmrUWWn1xz8kChPpRSu/x6war7bQamsoRz?=
 =?us-ascii?Q?wenrzFf0+MzvH4jWd7/kW9W6w9Ec8swS9aKqp0HD/7PtXefne3qW3Z1UI13D?=
 =?us-ascii?Q?4vpqfnX10bvF+ZMhOqQ5Ac/avPAv3xqT6wewBTdAxC3b8Rs0YHYsYyVI47/9?=
 =?us-ascii?Q?zJ1Cdu0we3nNMZ9kPpm+Cl+M9f0uqEPLG96HRPkxcwvNJ5cNjNLwusF5yJ2z?=
 =?us-ascii?Q?O/UyljneVY4vCX4iMH6xd8Ff+vYTk2WMiOZ+ODCW/2f3ECFQUzuVhq6MLCUb?=
 =?us-ascii?Q?jfYQ09S3q0fP38LF383v4m0u+PsZoZo9VPMbR14M1NR/0djKxnp4KW6gZodm?=
 =?us-ascii?Q?2Xh+c45szF2OC5j0PF23smkmzu8XDhk4yk/zFMeiUGBFkzIDe40u9S4aIFek?=
 =?us-ascii?Q?j8kstmTQo+SgbQzLV5GvO+vjfO0ndB7IAbIcd141qehqUCVdd8p2yRBrJbdA?=
 =?us-ascii?Q?NRBbAKZqAYBgLvrcBmdsuvBABw7WQ7MIqBHf+hpB6NBXgAs7t1g4Hezj/TPN?=
 =?us-ascii?Q?S+6Q7ht7GUoe3TllZIP+UCrmmCGKAK+AYAmF+RuTI/3rAST3sfuphQk+MyVa?=
 =?us-ascii?Q?rYvej1bVkKbVY7FnjxCl8CZ+MaCsJCGaXBdVStCZhQq1QNqIn5mLxxEebjvV?=
 =?us-ascii?Q?Z91Pgg3mvTq1U2G+ce294S5Di8lBzZbOGsoAYue4Ecok8OySy766nEJLvsrT?=
 =?us-ascii?Q?Qy48GBuOQ5sLYF+LhzGcgyLUI0+GSgfk54s0Mdm9RSuByjf43Lx4b9kHd9OD?=
 =?us-ascii?Q?fBqN7r02uvjIR0LHzyzO5sppjfQ5XgzuT0aEHlQGE9+FGlWxdclLW5P5o0ae?=
 =?us-ascii?Q?ybRHPv+3+RRsDHtfPNgVdXWjdDq5cmeeDc+rXie0rrLYqaz5E9uecZHaP0ZI?=
 =?us-ascii?Q?61yOKUSnNbNyhf0Z2Ibrdux56WVnDvgL9Ht5TWP02AuiCb0FFZ2btfIz7HjN?=
 =?us-ascii?Q?779N5513RYVZjrLD0FdfGbRHwpjOL21v2eCqJlVKHF0HYcUTkauLq+dLP6kx?=
 =?us-ascii?Q?lfSYr0+YBNwGnwIoly5ZYmIS7hTSzh3E1WX2V439kVM2jRL+SruZcXEywtTo?=
 =?us-ascii?Q?ThdKgEI0hOtghWEuXjarpfU4eR0E7J9mKfwA6Hfh+EZvY9OQPhekC7IjfUPu?=
 =?us-ascii?Q?jA8OULbmbO2KcBAJhxiS/mUM6sA4XjlBczuzTOIzlZMwvsSUPU0yPpYT+U8h?=
 =?us-ascii?Q?Rfd6BWhRMdY50AJa/FNiANTbnNXABmi0CYJyrCrZYwVWtknbTWvQTFpm6An0?=
 =?us-ascii?Q?g5jytpAcHuxOK4S6r7t4v/lsK5+KSeJPp6dfq26RU1ZNUXDQILMvwJr3p/IM?=
 =?us-ascii?Q?8pyq/WrWDawMiY/kohfFEtwzmz09UwMRaaXAm9H6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3161cac6-9e64-43b7-910c-08da5b7779a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 15:36:32.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeljUlcKW7vxSOrbY7XEaHlwU+UH/09Bwxcf/MF554n9pPfHPKOY3qXflYPt0db1MTf894XL0ILdqkuPkopQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB3169
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: dTNf5anIeg-mSPnNscmK14QS0F9yu4nz
X-Proofpoint-GUID: dTNf5anIeg-mSPnNscmK14QS0F9yu4nz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=823 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010061
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Jason.

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Thursday, June 30, 2022 6:58 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; Hack, Jenny (Ft. Collins) <jhack@hpe.com>; Zago, =
Frank <frank.zago@hpe.com>; linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix deadlock in rxe_do_local_ops()

On Mon, May 23, 2022 at 05:32:52PM -0500, Bob Pearson wrote:
> When a local operation (invalidate mr, reg mr, bind mw) is finished=20
> there will be no ack packet coming from a responder to cause the wqe=20
> to be completed. This may happen anyway if a subsequent wqe performs=20
> IO. Currently if the wqe is signalled the completer tasklet is=20
> scheduled immediately but not otherwise.
>=20
> This leads to a deadlock if the next wqe has the fence bit set in send=20
> flags and the operation is not signalled. This patch removes the=20
> condition that the wqe must be signalled in order to schedule the=20
> completer tasklet which is the simplest fix for this deadlock and is=20
> fairly low cost. This is the analog for local operations of always=20
> setting the ackreq bit in all last or only request packets even if the=20
> operation is not signalled.
>=20
> Reported-by: Jenny Hack <jhack@hpe.com>
> Fixes: c1a411268a4b1 ("RDMA/rxe: Move local ops to subroutine")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
