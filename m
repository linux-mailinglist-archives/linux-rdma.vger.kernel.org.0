Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0F461EE8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 19:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379436AbhK2Slp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 13:41:45 -0500
Received: from mail-dm3nam07on2085.outbound.protection.outlook.com ([40.107.95.85]:13024
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379642AbhK2Sjo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 13:39:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHIbgxCZI3si0G1rirpRzBi1a2yfUWScCQjeG6Mba2dA1cul1aJ0wKNCiLzXcReepCWZFX2WJYIAj1Yj44L7lu/qNvO6x81uOVj1CdivxUSneuw0EKYSw6efQcI23M8Kv+xbkfYsSPfwBNwDWuuRMo475HBa7ue+CDp+t598DvuV6SXZcIcsXhIGDy1r7WWptst6uV54GFX+GCZ0WyXmynfghOdLQkohiNniZEueMll43uGesQaIMeZDu5FUjlXKlcLI6TbyDcXe7CQdfkhaE+N4ZSu0cQC5l2PjHLczlVGna3wpUOOM8su5w0jmjnquO2ClXnlVSM5H4C8Dn17IGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYhRDokKylqDYqlMVzrszXBIaQL9Ms1JhVDrzgM67Qc=;
 b=HU0qTo0ChS0TS6b0UAiFHC0fG5kKkTB0utrJIJCKD4Z/Wd/lqfzo+q8RSTGaeOh9ohf0aR6o1YrKXVx2Q8NYJkLzd6RWTzXQ/ijrYhUUbp/fvXnTQdfDhNyrma0HOZjNc/f3rPEcbLwrKdeaI4cw6O/IpgdkZKFGpWSGiTopZdAbUzQJjCfvmg6zr1M2Mbhm3Y8523IE42TFGTFuy6FsHonqwSkDHIl59w08d9xcgny6x7P+ySPD7n9cvrCWmxO2suE+seLqem61SDud/vqvjAhT8n0uNAXClMyN0waxJFSlEqXd1Ngi/gNiKb+Idp8OLBE8ws3b4d6PxsYj+uHp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYhRDokKylqDYqlMVzrszXBIaQL9Ms1JhVDrzgM67Qc=;
 b=lmqRKyCXa1DphbYChz9FI24JZtY3KLVu1fMelXaYsaJxF9O7BoKu4rNEBE+Fyx4wW4j275BB/oMlwx4rsnFg5EtcZ4f8vlNIvVNqZ3vHc3K2QyWGk3IaSSsmL3J0yoIkdBbJpO5tOxsHh1V2DoAwove3XtGBTf4+7C/x0xhdLARN40HgT9miNNwrzZ8bdEQ9CzxJuclPU/baLTYEkQB08KNQeMnHQlMs3dLuWprfaSyTED/hEGHLMVd218HIJ8kl2+wILVbnSSqBgTZIcjlXEq27Q0tLyGbbjzP5e9IpuNY2XTMg5Sop7ZmVRqTPIV561ESKsDflcezleMNBb4ZIrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 18:36:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:36:25 +0000
Date:   Mon, 29 Nov 2021 14:36:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     selvin.xavier@broadcom.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/ocrdma: Use bitmap_zalloc() when applicable
Message-ID: <20211129183623.GA1065466@nvidia.com>
References: <b157f9e1586fb4d1083cb4058d7ac81b10bb86d7.1637868728.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b157f9e1586fb4d1083cb4058d7ac81b10bb86d7.1637868728.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BLAPR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:208:32a::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 18:36:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrlVn-004TBt-O3; Mon, 29 Nov 2021 14:36:23 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0c29a53-5f1f-46ed-9edc-08d9b36725cd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51426F9505A45157172ED53BC2669@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Bfv2UI9qSJ8+2Pt+7KIiBMZGgy6b30F7Pj0ckTC6Mh2bCQu2I0CR9azipJXqnl8S/NedJ4q8zcJMVBzCaDiYNNVEJ5NdstAiduHZldWllA+h8uODF3cOASKzleL79WNh39s8gytnLTeMc1sMmy6EaZuZREqtCXgzle5KuEz87P4XAvm0SinCTkc+hubkwffvYf1GdvatKDtSuUpd/qrCHN/xXbHklC+6RsBbv7O86QKrc+fYYk5g+6GK6Yi2gd3/ZhwTid1UXgKi3U7dSYXAPVYF9Zp7F4Vn+glfDsTRMFCqV+BQ4sG7kvr/gFKzvhMiSdr/fLWsMLKloGMUB3pasFLpnGL9Xb8FL2PulLiceb2+tQK1nAVFbOomAP/yLoEY4syJ4iXepSc9o3zwe6oipxZbsl8RKmTeYS6Ih3F42WKsvXCKWm2CYs+Uu8mmSJTbPL/ha9vAh+f/Ply+Cw8AgFDtgHpR4sJ0acpsT6Ohc4Q4TUo43U5ha9ccIuS8dWoli8Himff5kIhDDNABAK2FWPoZhh935QlGKkh/swvO7U5GI6IjW2aPi5jq1ziVXB2x2/kfj2XRTFKMtanQILcR0NWyrUZSwqNcOeuLFlV6XwB2WHe1kYk/yDqtZQk8HMgECHO1Q84phg8BoBF1UHF2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(83380400001)(8936002)(66946007)(66476007)(38100700002)(426003)(2616005)(4744005)(66556008)(5660300002)(186003)(86362001)(9786002)(9746002)(26005)(33656002)(8676002)(508600001)(4326008)(1076003)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Te5XOOUbZWlq5g2s8ln/LIEaGjCY4PsY5iocx+KOsvlASARgZ+wb3SJx8zLJ?=
 =?us-ascii?Q?AfwIJka+98wghQ991tFfWlsiZi1RBB6h5ZbLsTxmKb+w8GC6jPSTVxuU9ZeW?=
 =?us-ascii?Q?6iIvcDE5XGIRy6OOwgW5L3sB141KATUc09dE7WVUMvxJGk/OaPpAeUVk8oja?=
 =?us-ascii?Q?b6TW2zvaV/ilNq02iMOyYM063Je9PAaKZ9VyE9jDjbR4k+ZSOmMZH5KjyjIa?=
 =?us-ascii?Q?kUxe0t8bT+stvYe0ADdeVCxGZIMREo6ZadO6dYo6ZTavUG4sqOluHHoRakxX?=
 =?us-ascii?Q?v2OaUbF2dN1EjDZ7fzXrSL4ZmnStUd/OIo7cK6Tz2p2Pfiz1L/3kStaaFNtR?=
 =?us-ascii?Q?IMfh8ltWUuxW4UFjF2G5mzuhYSQQUDmoZU1B6S93bkgyKzdKAllXymG1VC6Q?=
 =?us-ascii?Q?8zSxLLg2I/qQCoczae3KilSee9alxJ4uxKOAjgKUlotli01hyXSJrkeMr90f?=
 =?us-ascii?Q?8AA/MVWbVo0TQUiOU1NFq4rbik3atg1+prOtwAr/m6djpXQ9tV5emrHDgS7a?=
 =?us-ascii?Q?R/6ieTCqLjf9+9f8YadPpqTNFKjW7UIiB+GOfupCWEe0QW6YSq28huSgno+P?=
 =?us-ascii?Q?pzHYorE+BAQj+aiJpRFH124UkcNBIzLaBYo9bjFgIF/xYE6BLJDK300MC2Kb?=
 =?us-ascii?Q?PeWsR9T+UKpYp+vddKNgNUlHZK6SqUbSJoQ/Pf+G7u4/+RwoW04U7pPT5tkQ?=
 =?us-ascii?Q?dqBLVj4TVrmOGuMgHongMdreCS6KpdOSJsjudddbHsdhKJohz+Bll7+22gE6?=
 =?us-ascii?Q?Rfq48ns3YhOlukhmfB6JYTzNBgRJ/KbopNyd2mheezbA1yq60wJ7c2tlfowM?=
 =?us-ascii?Q?+OMITWqlxAcRomORuKWNKhKr/OOmM5e/BQbI1AnXnSwMCRiLJlA2lHd7hY3N?=
 =?us-ascii?Q?+r33tT6US8ulXpI/HQgesUwJyjhyhkh3XTvJRRf2/QtyD7P/UhBTlaMeQKQu?=
 =?us-ascii?Q?yMR1mwaQqtAb4Sjnr6ZUvRQUg49OQ8ZowcFAnzUvj8FX2CCyXkzcnRe6gQks?=
 =?us-ascii?Q?iv0LiHNrUoYskt00yXX93cVKgu8lYb7JTmtAhDgSYaqWChpz486BAnMeeXpz?=
 =?us-ascii?Q?j28blbQ6HA9ZlslM5cDX/RBbbmNYiA+bOZXIfckQgq5HVHnhdM2Ps4E747Ir?=
 =?us-ascii?Q?J3DXsLkgOrBphplJSEObCfx4zOKDrVNrhw2zYQYVmCxJqYQR3IjQpbs1F+vk?=
 =?us-ascii?Q?kg6npdbOWDb04WxveUngeosmaWESf1zorgpbxh/p7fTIKDU8LtzaM7EI7igc?=
 =?us-ascii?Q?pb6GFGjLspPCPpxhHT8ZO+dFM3n1vdtVeonSJbRJC1ro+ABNHZ0FD+JxFPeG?=
 =?us-ascii?Q?2op02f62wlXqmO788tLA5rtMR/zsCoBC+0qk8N/boa6ZQ99ejamJbOU8R103?=
 =?us-ascii?Q?n5KsFnKRFOIoy3siZEWHS0i4gTWCC0nvVlpNqDHFCQ2tCNEKDftJTPb/e1T2?=
 =?us-ascii?Q?pLgx+t24FIDTh4YYt8GH/NeSmVNw/PJ+/k4pe+yb+ftjrseBot/0loysz1AC?=
 =?us-ascii?Q?h1Td2NaJLBbPyqlS3OFP35/ilteHVbUs52NAioPqhrpTLuZXv/fSvvcsuTZ8?=
 =?us-ascii?Q?f13YP+0mkOitbFa7WCw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c29a53-5f1f-46ed-9edc-08d9b36725cd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:36:25.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NnwZCseZeNPDwnq8bC4DOcEbe9R7fCZy7sfJLqzdCqnt0WnCoGD8BfvLrb5Yvu/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 25, 2021 at 08:34:10PM +0100, Christophe JAILLET wrote:
> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_hw.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

This and the next applied to for-next, thanks

Jason
