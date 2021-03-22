Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD9344C27
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhCVQrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 12:47:24 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:14369
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231346AbhCVQrJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 12:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIi8EHp6cD6ZTgPONt/vK228NqcqXVBHRtj75/g/0GH6wC4meBgHIIAv2wzy226PB1TatmBeK/Ju2sTKZPUeX0vkR8ksOwlMBUGNe6iPMLAdZMU9pLLOEhNMhub2JHrtTLjgb0XxtrdaI8zrhDtXaHT3bwadBB35Jwfazdb2Yyd9D21yty0rQhkKrrABawNVegDUr1tskSqOUTMZz5hhJyfT1p6zl7Pcr1B2ZQVUx3GN0CEqjDRgcrQwoVzOcDXHqwv8oEjUCyicLKec3UHyyf5MdHwKHwNjuZN4/h/pOzSFJD2p3bGlvKlPBHdC9g7Ghgp2bFYaVnU33n/vaLv3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5UUI6+7W/egcX5jXvJjUpFEZDS5mKG+Br2gPxuwpJs=;
 b=L3gmBQieC+axF8PxjNPjxyaLntaLcOmrlvrLedmnZqF3uF5nDG37oAe0dB29iI/uSXTSsTQDsCQj7FaGJuV59cOUYialyKcv6Ol1v2/RyJmCX3GhKuqfWKLk7m7o+THMoH7D50IV9YrcFNtVYa0pKSiX+i+MnLiM3yndgRE7/ejNwtL+jVtjmSjYvf0FRL2MSY+1ARZVma5ZRxUpzHqldfoSA1WTARLm2az4hyS0Bbq22O0DrnfVqa+h+IAdG2eqpdlW7OzXXc/YewsyD1nne5NELEC7qbMME4kklh+Bs3RKSbn/Yjw7+jlNPbnnT/XckMBUQDJn5qAECIy3pbq/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5UUI6+7W/egcX5jXvJjUpFEZDS5mKG+Br2gPxuwpJs=;
 b=Jegkt1Q2fJbS+uvV81DD4UemLDMwCVN2Le1sasvqFiaRpWjNLtwpOOTV4ZYimHdZGMN+HbpPrRdutxRkKWld+fd743Cmvzb9RrQKtJ5fCZww6jXHkVaT8ObHAF2px9o/zChaBhZQYAXS9BiprYSIB44eXiq7khOy0pe+Ox6abbYf3Qu12nMx7gm55mPj/XpKwQCuz60feRNTiOyFvuy1DbpBhHxbL06oD09R4C8E9Kdplwaw9HrjTn3rbM82n/gwEcQ9JLbs45sGCcz5WemE61U2uG7wZArEaA9i67NOuVnwYqVYT9XUlLSzGhiwjpmExsEJheF76Nd4ZHFsn1fkQg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 16:47:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 16:47:04 +0000
Date:   Mon, 22 Mar 2021 13:47:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210322164702.GW2356281@nvidia.com>
References: <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
 <20210321180850.GT2356281@nvidia.com>
 <BL0PR11MB3299321214491E0C3F9AD515F6659@BL0PR11MB3299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3299321214491E0C3F9AD515F6659@BL0PR11MB3299.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT2PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 16:47:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lONhm-0017ti-St; Mon, 22 Mar 2021 13:47:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae37cd28-d7c7-444c-98c4-08d8ed521f8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37385A0B60459EE3DB0C221AC2659@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdY7xKdmw5SRta4V5K1+xEp3fQ4F4NOm1V9t/ZxQx1jnLDT5Nfofak+p0j6Vww2ig/aINiym+1QBVG3ee4RDnwQ7qQ1saOQDjdr/Ci+WG+0lDAjjLEcNivt2RxMuq7WK4yc4Cq/fmi4nxZmwR71Lmok3z5S2oRvvcjOaBvCh2basBClKodyecSK89orRmGQqO9lbpyys2ZRK6cPivXrdJTXAnvaRglDYM99HfFmzEMcWUghNJt9ZN8GplZhI2iz2pXzTg7UUdgextG0Lt8/taCsmLZeRApBCBYbneMzLVBOfqbtdwbbSOoDrxjiKsAB1HzF36wU3pBAuQ3B8SscmcZOEwTCFXv9FN8gQMKVwuclLfTD5O2/vQoN+RrNigosHFOf4ivd7jagw6MYqwO45BZClr7fb2oIP6aN6ID+J2pn+BbQqOdNRwCEjwTSVjWfcXeTZirjse4DQXWC1Tu6GT0wVMgOu9T39nxydy8OG2CF6qbnciym8PpZ18jz2kgunnGHhmkxUfKMuYN07oCvX2UwFR+/vj7mjmWKv8IqNPX/KIpplxCPsxcRrJh+Hnu5a1dKArnDSkgao2UWRBXxGF9bUZsKItmcXl3dGNDndomGpqeDv+4HwbKVpA0VfNQKjZf6h8VypUNVu6fl37T9pMaEJlQ9bjdnvaaX32OOQQcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(8676002)(36756003)(6916009)(5660300002)(54906003)(26005)(186003)(38100700001)(426003)(8936002)(9786002)(9746002)(1076003)(66946007)(2616005)(2906002)(478600001)(66476007)(4326008)(66556008)(316002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uABhG+SnKQ/fYR4SHkDOHVEvhSkqLtG/iHHppAcdI++2EPkPhIS5N1AjP67k?=
 =?us-ascii?Q?NfeanGzi5HSoJKY1KXOS0ZXNrVU2t4xGFsNyVV+Zuz7q70cEld1A8LzzIBYo?=
 =?us-ascii?Q?MItBz+8Zh3TkMUX0qB2+n5wVd7DMRgs+bhQKw8mTbKNoLmfe45KNNCpBTq92?=
 =?us-ascii?Q?jECt5G+/Dhi/nYjQv3FPsWPooasQ1JkVktS91MHgqQIk8uFSupwLfDq9tbjy?=
 =?us-ascii?Q?hZmu4fMPZyDf2SrWtaOAm5cq3NSjhCL561IAIwhQTVzxbL1vcRs3yYzSXh3c?=
 =?us-ascii?Q?DNAZSD0uAlZ74RIPonfq7uwCxuiDhKuqQVfzf41xY6iPNGhEK4/pB0nk3/bh?=
 =?us-ascii?Q?LyUMdbRvO5/uof6jWod30sA//4Kw0iWe+5HTDrdRq0LBiSqKvB+P3jLnbU3R?=
 =?us-ascii?Q?bk+hQXTaQDY4EhhnvNkQLlO66/zL3i8DS52tBUt6Wq0iLcZ033y5GQxZOZ4c?=
 =?us-ascii?Q?LCKkCgxIdupImzdQOGaJQETLCzmu40/VbHPmcnt+o5mwkniErEPCLopG4CLl?=
 =?us-ascii?Q?ehyDSoty2EtI1SSUqSu+fp6pPhjQg4EU1nfdZsoUHuwbTmPrpS7Kv76byA55?=
 =?us-ascii?Q?y2uXLyEJFMnzYsL4GnI9/FMXATo6CHvdoJPeBnk5NMPlhp+h4hZGvvf4I9aG?=
 =?us-ascii?Q?M0nJEkRjM+pxKxYixnoN0MjVjDYfzZbrdgmucuRXqaN3KdAaPGOyouYcCidy?=
 =?us-ascii?Q?u2d6JHKQaX4Igb5oS7EAJohxk9Fg5m33Bc+KYnYHFGtotoOt3rGhXMy8TjuK?=
 =?us-ascii?Q?FRYeod9biAXSOxX9uGTl+f8N68BpN/6vG3SrliTZ6DMJJ5f9BjRfUBvWPwbq?=
 =?us-ascii?Q?0iMfu757IAFTQkMd1D9o35TfN9H+O/GGwPHY9rK4l/HOfWqrInwQVVM9TPeA?=
 =?us-ascii?Q?rfUmXccT5LrEGByMFX7xyH5ARN2R1mdbdpk2mG0SqPoV1EovHciFZsUZBYub?=
 =?us-ascii?Q?zRMB5AXKlRHl9H7U9efW1qudebsqxxqxaw/g8MMcxSxTZXbRrRqG2rmUP+0V?=
 =?us-ascii?Q?K87JidwUZTuWCEOGpjavyM08ADt6wx3+TnITXK9X/F/YVT+6wZcDahtv5LTJ?=
 =?us-ascii?Q?2t6USfIhSAitwEgzp2F+Q23OhnhtWh3qVsgHAabNnRb0zdNuNxqEIoL9lM2M?=
 =?us-ascii?Q?ck3EqR+bwtuj7DP3b767qrrIB48be77+r0/6yZeY2C4TTnr/P/iflhkSXhEi?=
 =?us-ascii?Q?WfY7OkCiCg8P2VNzGXmROreExmYdpKnbSZ5V1LEru1wzyys8S6qdHgT8wy/H?=
 =?us-ascii?Q?f76QJb+Z7ljN0G4eoGM1wxek6UCcFmPFEAzKwrAzyuuF29A9gBdpThC12N8m?=
 =?us-ascii?Q?7ibG97IQWk+BrS7e3XJ6jTFj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae37cd28-d7c7-444c-98c4-08d8ed521f8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 16:47:04.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7Qf/H5t4ZRxD5DfHEMoob9KAiY7UhhOpMTqRNEx/Ukdx3a9g4bVBSLUKrt/Y7k0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 03:17:05PM +0000, Rimmer, Todd wrote:

> > Over a long time it has been proven that this methodology is a
> > good way to effect business change to align with the community
> > consensus development model - eventually the costs of being out of
> > tree have bad ROI and companies align.
> 
> Agree.  The key question is when will nVidia upstream it's drivers
> so companies don't have to endure the resulting "bad ROI" of being
> forced to have unique out of tree solutions.

If you are working with NVIDIA GPU and having inefficiencies then you
need to take it through your buisness relationship, not here.

> > > Putting a bunch of misaligned structures and random reserved
> > > fields *is* garbage by the upstream standard and if I send that
> > > to Linus I'll get yelled at.

> Let's not overexaggerate this.  The fields we're organized in a
> logical manner for end user consumption and understanding.  A couple
> resv fields were used for alignment.  

No, a couple of resv fields were randomly added and *a lot* of other
mis-alignements were ignored. That is not our standard for ABI design.

Jason
