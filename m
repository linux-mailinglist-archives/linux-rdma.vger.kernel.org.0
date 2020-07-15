Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B2220BFA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGOLhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 07:37:52 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:44404 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgGOLhv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jul 2020 07:37:51 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0eea8d0000>; Wed, 15 Jul 2020 19:37:49 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Jul 2020 04:37:49 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 15 Jul 2020 04:37:49 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 11:37:48 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 15 Jul 2020 11:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMNAOAr650akm/7dDas7BTAIPVDWKg3++jqjVweL2uJ2tfmVoHBfpFNWPavSwieuNB55fAEUvQYTuPyeu9R6grUjtmYsUOdFbuEXfHdHGO6jcmpMLU+yzt1u+Txcg2LK4h01ua5Y9TIO8FXHnP7ZFBnQE0DRP1BzfcdFvAiARrXANZNEHtB7ZA93PqDrmktx+vMstAMAn9hO4cdCQ1kItjJjK6Ca9qFNsTKtXpW5fbeECp2+eVsxwDaVvtXPPl2rwCrAjkDJD1c97oy659Wm8aa5Yu+dXmsH64Bv2bZxE6ITZ7PHhCzJxPSiRZFmpQXgqN9memWUd5LbZqUrdurHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVQoQwE0i9TxII/9RDa0YbA0pXsWx/zodF4tyKdGJCA=;
 b=nWeztETDxa7AIGUtrAKZsqs8c6IDaTOwSa7sHA3IBpeiY/2nd/5LamsMrvUE5aEOVvaSSdwzJYzXc9g8s/0ZGlD0OIE5AuZ9WBepTMkujlW75RUw+/dcmbMke2Y7qm/Veu1XcUQPPym0qpbDHcmaqWemipYfk3U9CgzHwvv/3v23w1yfcz4N8IHZ6AL9EoWYzAo0GdXVZXSaESh4mWCQnuokPVxiJU3DbeqINtmI334wNxoFVDYsjPejZ3z9+1098GY55/MSntvu8e9gCDW+c+aZkYALOkZwBe9bJEa3Aagfz06Gc1zN6xctManq6v4kLDD9b8xYJoqje7DeTcc1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 11:37:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 11:37:46 +0000
Date:   Wed, 15 Jul 2020 08:37:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mikhail Malygin <m.malygin@yadro.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sergey Kojushev <S.Kojushev@yadro.com>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Message-ID: <20200715113743.GC2021234@nvidia.com>
References: <A9F28BA8-EAB3-48AC-99C0-09E93D7B9DE0@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <A9F28BA8-EAB3-48AC-99C0-09E93D7B9DE0@yadro.com>
X-ClientProxiedBy: YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 11:37:45 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jvfjL-00AaDe-Hv; Wed, 15 Jul 2020 08:37:43 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20d8234d-c7e6-442f-85b4-08d828b37e5b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26033A1F42CB2B8833C1A8F9C27E0@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppLJ7immwoev60zN8KaKYIz/uGBKKNCrQelSziH6QVnfepecdqtc/kF1dSy6gCU+Sf+Wpe+eXaZxR1E0A+IwEHo/vJ6Cob06Jr3sJGtHgKwkOvC3AX54ZiN0u8HmK1jVLiZpOF5/EiHaPQJoSazhlhNwcd4JKTkWnhGgMs9+Aq+boUfSVHtrap7tqJ5dTZdKlC6UKujx3vspCGd0RvaWVL7ogxoISddLTp+WgvIgbM4Xen+Xh9DiEDGckk4qC/3T18OFM8VnoOhICJShAz9HDu4RLEol9Q/1OhxqXY3Y8oq+4wwK6KYBgAPpHXKqmAsOwXJVfqtljXRGgOc3sXv9Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(366004)(136003)(346002)(376002)(36756003)(186003)(26005)(54906003)(86362001)(2906002)(83380400001)(6916009)(8676002)(4326008)(9746002)(8936002)(9786002)(33656002)(478600001)(5660300002)(4744005)(316002)(1076003)(2616005)(426003)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9EZTfUxr+7Fdd+YzvI5XecaiQr8WcppDxREYWaaExRlba8rt95AiplH9aysNdckm+WuUiBCtkxT8caQxtNywk/b7yO7xbiKWjcy/ACxEw3Vmz7tjH/bOGh1yrs+zFulXw5lqLCLjSxfz87CJ8a/PiCBYOKCxE1Czbln54dWqYL1MeUxYk2PAxpB/hYiqBhYBk22GLwdDUp7X/P8250Oo5lnYSwuFMU4Qnn2FixZm6bl8mQzfjlLFYY3kbTwRRB+sU2S3dPEiGMT/91yp2I5R1OQtiyGP5C8SInPVHdSbnEd63Adq5KlOzUf7IIlYbRG0Y/pEUkeZozL5rmJtdpA8mXHC0iDDaE+n/jvr1SSl/hKfii2iXHcwqbNTsrMB/YxmTCu0T0UdsIm5NhPzIV3Cv5EOiIWaYzDErNijpR8K3H1a/uh+r+hIcDrNjQcZHJBRoRchst/A2rRjpGlyNjqTXSq442ozmsZMrEWaAENjBL8CDDYZrN0Qlultbzpbm5NS
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d8234d-c7e6-442f-85b4-08d828b37e5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 11:37:46.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJBwxOhsO0bVrXSFZxa/h29OGEiR3phyXwirrEtx+1oZouvtgAEnZchMjVEP1bTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594813069; bh=d+IaYHGMweZE92rGGoq/A+Nv798+xtmndYLdlJ2oJzE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=VpQJ51WoWnKacvfsVswCm2W0aelp1fZwzXbkS3aWLmszS77wZsMQCB/Ev7kbaOsEs
         c6X36yfLxMMVQR65hdWTiz/nK2Y4RsxuuTwpo2yyCqLvdWe94LeK+YIxEwQWvKhhzk
         6GrFAvxMogJMCBKHlCbfkB5rjp58jgEQUprJfWuo1xtSAQyoxo97KrDPbDSMTjf0IH
         04xI+T+eNAjTXlYqssgyRCmI2WTG5WV2SaYzyL2E6jR13r836vDDlJK/YIiK0OZRDm
         CLuAIcfJUJnsMkf+eWQOZlqlh/PV/IMSJzpNNgpTon0Rnv/48sIRhPFVlE8bVKM9Sc
         /U4KHkTtz5L3g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 08:57:40AM +0000, Mikhail Malygin wrote:
>=20
> > Why is this READ_ONCE? The wr list at this point cannot be allowed to
> > change
> >=20
> > Jason
>=20
> The idea behind this READ_ONCE was to make sure read of wr->next
> happens before post_send_one(), as there is no data dependency
> between post_send_one and read of wr->next. However I=E2=80=99m not 100%
> sure this is necessary here.

The spinock in post_one_send() guarantees no reordering across
post_one_send()

Jason
