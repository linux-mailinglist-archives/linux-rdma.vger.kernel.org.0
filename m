Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B384D3B355F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFXSPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 14:15:39 -0400
Received: from mail-bn1nam07on2048.outbound.protection.outlook.com ([40.107.212.48]:52642
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhFXSPj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 14:15:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/NcAheuZJm8ZFqz+zXQBldVA9pwX76uuCO6kuP0yilMLtriAbfCaxc+IXuotIZHCzScP3RCrj2McRob31Su0VTPhdQSkgq8C2S5dqVT6yJHeJRyrkAWKEBE4axR+D5vGrH2TweQGxfQspWG38nsWIBRGVsJDbZRCu53CLCZXrfhZVADDdJyETdmIV2nJm4d3lnCScPHl3s4sJXG9QsbUJ+/rRXcAZFiyZbsuu9F8HzbBV/YQ8trskzdbB5hBdFujnpwmrBcuMHMv84wEjzVmB/RemKlU8qGoUqS2DYXNU/OqAFBPZ6SqOoQNs/jAVJL9JxFopEwbxK1hcDFFr/MVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF+gsZ+J0i+o2lVYdhG3K6u1y2p8Dsos2q5OJd48IxU=;
 b=CcfJphUi5L6Kk3phyalVG3dZS9RZD7wrU/4ntlDxnd3JD3J8XGOOOWPS+3HCZcnSFUuqkspNs478uiNSVELIPRFurmdSCYjmKrafzzHzQlQsRLjDbyNCdhZuxcavNqQeRnYG4ygIvy89wXmZdP8dC2nHb6sOUuX8JAxVYBPeA5hmg1GrGq92WZPuv1BGv+IaYtipaAdlW42nq/cQ0AuE8l3DgtfE2oSBtkLQEwDAmpXK9GVaAjz5wRcGUvs4FuR6CBBMamP2I3DXPQ2cuxBo9heb6BE8crwrw+WER779yiy+uhFEaKCkB8a7/dj9WaT3dGEJciVRjR3MbtaM+VT5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF+gsZ+J0i+o2lVYdhG3K6u1y2p8Dsos2q5OJd48IxU=;
 b=Kaxw575QGimIVg2iSuQcbyLtU/P6nD27BbqFxqkJA2Pa5S+Lh2EAVKyDTg8Y0Ve2KxQhzuGSGQ4FnmII3EQKwLkNuPa/sVbIdl28lZoG0sIYBfcB9I+qbnsMzAykFYXmoJpW8MKoNR8vJ/6MPnuLItFaLAbHOio10ophrXVM5g/PH1rcD+qsQY5QJke78smn4Hruzam4rAgxhhkKGDswiwxC6H9CxYCp06nQIqpMaNTwx365A4zVfLp3JpLbpORSzEJOx+1Mnr5VEYnM3A2MT6gQrg5bI9y7e3COHCDmqPoiiWRDX/N4f+/Llg2rYIMNFJlxsQRe+tNGooDOi+iVsA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 18:13:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 18:13:18 +0000
Date:   Thu, 24 Jun 2021 15:13:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ira.weiny@intel.com
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] RDMA/hfi1: Remove use of kmap()
Message-ID: <20210624181317.GA2915863@nvidia.com>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
 <20210622061422.2633501-2-ira.weiny@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622061422.2633501-2-ira.weiny@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0062.namprd13.prod.outlook.com (2603:10b6:208:2b8::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.10 via Frontend Transport; Thu, 24 Jun 2021 18:13:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwTqn-00CEYl-74; Thu, 24 Jun 2021 15:13:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9665c08-8f66-4f4f-00ea-08d9373bbe0b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53633EB4C8ECB2597125E416C2079@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gI1Qpn0UN6foHT5jmFl0EiC3p2MbZUySaRByQgu2uWkR7qulDk7tTm68Xo9MiAwVAVSvkWRwryFUf2ph4eYjmOO2QPpo9aDMKDjmmV0giH4hbIGTNSYu/MN9AinBzau2nm0PEdiCQ7qx2ZS46+eVgNJCCI80vVKsnmyt48awPo01P04DowZTeBVX7hsNsOtcsDv9uL1C/RRMfHWA8i7XzADBlHrRhhXwjDnjX5qkJsBbvuHbomu9znZ+FAZWgBddR6/297HCYqVrWZ3f9xj+681vjLAydEvCIHEG3PRiDgZpXzsU3/dTjLpQndxVgt6G1BC2/bsgCOsnbHzl2cJwAgSBhxXLjOS4UjhiAILvqpmhfHzRIJeYYtvCbrSj1MbedtiKMQX7k37q5YDRdzluMpxQqt/8Loce6CzPjZzHBjV46F8SB3Y4vdGlXhzWX/GAhwyM6UsXZ7T2j967ociRVIJP0luAhOq1FwgBR4ZEYcr3OEa9QBpJsVRx7Ao5IyeJjtLtmf+zPa4G/V/2ibcITqplf0qjS4TLk7PYH3mNxF/jWMT4jXML2owaIDs5U1w0CpdKT0hQFOWzjeWdWDRWBB5x2ZQk7+GOaoREt3vsbPa4fkAO50MqovLdL6ejDKWZH1jfUFmSPq+qmHdfI3Gab/WBnGJq/y+4jR5tX5/lpexJjVmoX1GH9HY7NwPZrmTgcPVmFWrV5AXfNAh2DzJVyee9PMaMToZrPm/6ypQcifk/5YcyeaaCUSngu8O1PP8QpgQOivYM8pkw53hcpYfmuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(4326008)(966005)(38100700002)(36756003)(1076003)(9786002)(4744005)(9746002)(33656002)(8936002)(54906003)(478600001)(66946007)(66476007)(8676002)(66556008)(316002)(6916009)(86362001)(7416002)(426003)(2906002)(83380400001)(5660300002)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1nyN1u4ELtlcb+VvbNaYYwchV0UGoAGeA3JYDm70p10KhaMgU3HFr7EZDyS?=
 =?us-ascii?Q?AQJvv0xvvk5Ujk8CFpqwmSMr14PykUo65kyEYhFiD7bTExu5F3iNaqXjVJ4o?=
 =?us-ascii?Q?FIjVz2gi4YIWs6HmtTZLMfy+D+8uKE2WtT0yiIYiRZq76pKC4tbJdnjo1uVE?=
 =?us-ascii?Q?yu9D9xKDWnC3PR1nWheLppH8SyTvZAk1RR3HElHl57BfEm3+ff6lXAVDRhVm?=
 =?us-ascii?Q?bBQT2Kmn0xTf+AgGQOUaQTffm/clnZjnwiH6GOIdt/l40VY25hVePyzd7k1v?=
 =?us-ascii?Q?ghxFXzXno8vO7GLB0lgyqy9iXEwspsPhxAbacUBJYp79RbRPU+BjRlNjTvWL?=
 =?us-ascii?Q?k9jKKbrjueI1c2kiedwRsXrQkI/ddFzV1wbZViJzXFGYQq9aaSLC+h64xPZv?=
 =?us-ascii?Q?qbYq56muZdYIlIWXvIh8zC4E7cv4DnNT+rBBXmGkZNLAcwZ2VrZgMvkQqzNb?=
 =?us-ascii?Q?y9jKJj0pwCnl2IUpEYDdwmkmCiHSO7Vny9awNDcjuUfu9d3b9S9UA6m/sneB?=
 =?us-ascii?Q?LLSTm/zxCycLVW2336a25mpfe9RhY+DAhRlXeGvt+EoDprFzsSD/A664Upba?=
 =?us-ascii?Q?byFyMPudcf7lpnxv9Y+kUDY8wafWPSLeAaiIGWTrNa4oxH+O80XTcoq0N2R0?=
 =?us-ascii?Q?+9PENhG9ZSsqHxo404F17wUFlDwtYjX7wveYu09AQ0HXR3NAD+WibIMqeJdR?=
 =?us-ascii?Q?9/MuAzzh/WtftbaDK64zJMeoQV4vnQ0q+E2qkE2qh+tFiO6ePtjTG0JxFpyV?=
 =?us-ascii?Q?2SfvrYdJgbVAQ5qvMCVk7SamufJ+PJ743Y6W7ZYiPyIvIiBlTdEOK+gHM8Zq?=
 =?us-ascii?Q?0Hr8L+FJmQPWmAI4diPxAkuSX2HwfV1bjQhheMRi7RGDbP/IR7xhrQ/BrjfW?=
 =?us-ascii?Q?WGPK1KaN6pqryN5Msid79LG46slgfygwvwdam99w5WdUrQ3BMUnFBvRe5RUs?=
 =?us-ascii?Q?IHsPfm5LDeVI1pzJiarCbD055K24YC3/r0joYGREwpZM/aRFZB6caLR7q457?=
 =?us-ascii?Q?Oi8ExyF5onSqK/oYUSt3MBe1HQdruWyeRVRrSAH98xdrDNpumyYTfXMXHhJ/?=
 =?us-ascii?Q?uRSrHd2jOSluWZXOFfFiLZUXY25L25fvD51lCP3Jt/GlnGdKcK6oDtMPTzLe?=
 =?us-ascii?Q?KpzaKolFWGUT/0zprwgwHwUlp4oR2IGNwexnXuZLY2QwRceVdF8K2EDg5/7J?=
 =?us-ascii?Q?gEhDcEMuWJ/SvOAEfH9EOm98DFry+h5fX76cw/46P/PZAY36upj/omDbd1MM?=
 =?us-ascii?Q?f/5gWZQaY1eleqyv7cs1LPIDjhSj8U+giZtdvLeTS9xjLgWRj4ffqqK/P0Nv?=
 =?us-ascii?Q?cDPO3LQrCCTmI3ZbnIBnhbn3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9665c08-8f66-4f4f-00ea-08d9373bbe0b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:13:18.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +498ZW7qUww8CXEXy0cUhdOizpANcy9y84+Ci9lxQ1L7gGQqBhB3jd5CwnPlrsLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 11:14:19PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap() is being deprecated and will break uses of device dax after PKS
> protection is introduced.[1]
> 
> The kmap() used in sdma does not need to be global.  Use the new
> kmap_local_page() which works with PKS and may provide better
> performance for this thread local mapping anyway.
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
