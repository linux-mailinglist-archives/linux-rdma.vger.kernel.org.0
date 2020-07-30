Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3855023340C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgG3ONj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 10:13:39 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:18907 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3ONi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 10:13:38 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f22d5900000>; Thu, 30 Jul 2020 22:13:36 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jul 2020 07:13:36 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 30 Jul 2020 07:13:36 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jul
 2020 14:13:36 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 30 Jul 2020 14:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVWwYnziG7ddDe+OrEtlra0+EevjKKev3PN7NiCD07Rvy7eVxG9/cHFcWBNDn+x+rj3J9sohyD+RrKrCnREza2eOm1/VI8jL7VpamTbA9+gwZDDzjTfEwsV8nTtz4K3M1n23rE708TxApbOtI9whW0FjP18Cz49CoDWrgxbUOS+wCKYBMwBuy73s4hVJa/OtXg7HoeHvrSVxYSypbsd3gIRFGBX6j76ZPNJezDFQMeSyfcNHJIHAaw9VZcy6rBPnjuBWvv/Lc+vU/Vdnbdq/9NxYBegVAnBuZ+D029TLn2zh1lY/y0G4AEUi6Liq8QsgFYyi/GgmSEXmkA+5qNqD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17lj3KiRNaEC/1axVBmKyn7C2sBlvjf5x9Vb2lGyG1Y=;
 b=Hkh5Z8e5lGTXgxoa++xjnR6FV93dJcwQmGNZn6qyph+RNZZpGKC85XzXo56zxsGgokXMBr0OKnjSvMrfIAiFs0uk9YWXzMPm5hg77l3TdJw8vEpE+N3SDtxxoyDnZ3aYKGLERTEm4oPcZZKArc4rbPZHaW2g9wG0hlJvS4eJd/4PGBcneRP5rh0GmV0F3rzuZXoc4Wcy5b9GigRkXrfpft0NAlpOUy7QofLf22+/rROFiSeobhRL9QeumwrPZZxXp3FkvLvrJd4wH/2yisqUGIlq7nEg66mWSziILSVXnfwIEuTjXuMMsKRHi1CvgqOvX+RBFnTQk5qv0S/hJ3tPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Thu, 30 Jul
 2020 14:13:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 14:13:33 +0000
Date:   Thu, 30 Jul 2020 11:13:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/3] Simple fixes to DIM and mlx5
Message-ID: <20200730141331.GA349702@nvidia.com>
References: <20200730082719.1582397-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730082719.1582397-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0055.prod.exchangelabs.com
 (2603:10b6:208:25::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Thu, 30 Jul 2020 14:13:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k19JL-001Sz4-Vn; Thu, 30 Jul 2020 11:13:31 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c70570a7-c417-4542-e3b0-08d83492be08
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:
X-Microsoft-Antispam-PRVS: <DM5PR12MB175642D8B742213DDF316E7FC2710@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5rZWRQEx63/V88fj913kumGwaY/Nl9kytI5XGre3Areo+sOZeVEFntzG4tzWSW1E9fHQLI4BJJcZVpqhJfLfKXxKTCtyQmV/ql4DK15mbMnyPgF/3agjDHlGfwhoTDR/y5Cb709/JfidIkxsz0n4oLklvOyW91VW6xiTC/lN8cefNOM60N9FRpPrylNutBxKrXiyY4fhYGeIEQpVd3+OYLiNBLKM6icij4lk0Td827mh4Llmw/MlF3VHgpwReNOXH8h55XAIgWnML8QtFgV5JR1Ts02wJkkWbX/+GapW+43Ap+XeqWxcxCiGiLyIluUAY78KYoaCIXv0ZmpgQfY7z/M8ck7TAJV9WPo9ckIthqRdrk/3cK7srs3Pa3GJcOE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(478600001)(4326008)(36756003)(186003)(26005)(86362001)(9786002)(9746002)(2906002)(316002)(2616005)(66556008)(426003)(107886003)(33656002)(6916009)(4744005)(66946007)(54906003)(66476007)(5660300002)(1076003)(8676002)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2KXeHrdWzRI/Oz9OMJqKRT+yy8PHfgxh5x5dj8URRebJdiPxJ4UG81W0nSSlkc0ewLPDHyG1gR/FE0UyH0PcXlLfYvTTryZxdLT5glKIYHjUh1aWYoTHlkH8Nj9jehfHGX8kIyKNJalBlJvjuUDmwfLR3b/IgxD6UhBJjzS4X4dD5aDss1oIXvl8PR5jTlp0zP6YjDicycyZ+38ogEOSX+deRUBs71nsVB2mwjcaM7jdoRpBbn7cp6ircC24wAtJd+wnM5szKCgt6F/kL39ysb+w47ReRrOUj+Co6xDddZu21jLeKlDwKoEuOGq50a4LPgD3y++TzbvnQBeX8GMne8mfiyZ2oKORJvHRkoSPwsMKTJdBjERrmvNVK/hT9CewJkm0tLHqc8bnkfqIrvAu5mxmepbft4BtkneFJvtR4bBNXLlhsUB49OjMIcEDiz5vqQShZcqJmQaJ8o/fpNpuxOWsFjwyBiGuXxPvJRGX3ac=
X-MS-Exchange-CrossTenant-Network-Message-Id: c70570a7-c417-4542-e3b0-08d83492be08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 14:13:33.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwOOyX1elLG1xIxwvg520Yv2W0cDK63rlsq0DwbTrXT4N29p8mjq99pgfDsSrY//
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596118416; bh=17lj3KiRNaEC/1axVBmKyn7C2sBlvjf5x9Vb2lGyG1Y=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=fzpLxMHSWSzcQbbSrr1uIZvP1UG++nGz1oA8KQgAU5f25rriXfAJYkmdycbzBMb9G
         m2Sw4Uat89NJgWA61HBwZykcXU8pM6gVjfbc+cV/3oc2DequsCQloFYEqKCy+XhApx
         B+r5zuETftIb7Lfq6eKN443Nz+MWoO4nPkv6+11HEkts1OhpyjpTbCoV5DJ2jHNZl+
         a1U74oEafu3dbKoQsBDVR6Bme+/4QKRrjzODMuWeQCwcKNqZaz0GqSYg+rIMqbmEUc
         hK1qqszsUx7qF4tR5S2+3HQ8nVIy0xHnlChw8tdHTUTkjZXTZLCA6SAlI1IBOLcjqf
         jqxqs/6jglCtA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 30, 2020 at 11:27:16AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> First patch fixes an issue observed after auto-PID series was merged,
> but because the bug that not-initialized mutex existed before, the
> patch is sent to -rc.
> 
> Other two patches are fixing unwind flows and appropriate for -rc.

Applied to for-rc, thanks

Jason
