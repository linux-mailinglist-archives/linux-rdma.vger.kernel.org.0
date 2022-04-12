Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8774B4FE37A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiDLON5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiDLONy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 10:13:54 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28733C69;
        Tue, 12 Apr 2022 07:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVoRCNDI2LPsumzVcMeL+9K9pfhsxQs+2/y95Lp6XjUswAY2tcUDagnu8XtVWE2FLDdWZo/AFAKyJ/Wa8cxKH0JSX4O6di7ckwwisuFdXnCQEzXpbZZylQhrpyLY36mZvc5YxBWYq4+sqaPGTNH9Lz2G0MMCn83neADCRuMugfBaAI2ikF9BNyF+70o5PEyDvikjP8EqwqSqCthJG3JfAurrQCkflY8zVNiG28/anFXefhu4PXqKoEXRar7hTDXsrZC8mZFGLzg1MeKcYDc9s9jenJLHK7bLs6NvqNCDF71PtZT8NplHheG72lsyBL4LsZEqgIc8XeEtwYhG1DIZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIrImIrctn3bW4S5q2Xooh7gmbABAn5cqDvd1HQYpb4=;
 b=hvAjL9wutsgfX4rVtLjSMento3K/3n01FWvMBxppZBRH+W5TtwD4yGb424cELkhi+U2o4jmWN8M1rgcpZI64cNBUOFI28I2QFqYJR4uJFTrzs2SEswO9VdX07Ve9EDPGjMRyenGN6VsTl2cCKNrhzTKg1yLQGa4HdLpikzYgooGs6z7wekOVyul/UVVVaqkXkfBQuQ6bmUjHIpiZKl0WhIyEbYUMkib/l+2Xafm+OWcX2+qYBwLlDWMkI226HR2pPsyBuVYSYCBVSwsVodzwpPkRvK1byrPDXPCb/dUeh0WzAXwUZ9Lktz5FHjpr2DDG2QePpaM74atCSaCSVsZwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIrImIrctn3bW4S5q2Xooh7gmbABAn5cqDvd1HQYpb4=;
 b=SIK4Kurqv1SRtiK8zuM1WHKrwjlGWiGh1ZZ0NuFW0dHLy6xWuk/C7J5daFvYVvttGS7R1lZ3y27Eu4POukEurz4Y4kexTX48Qnrl3fpllj0ELIfGOaNLsI4Kcp86NVdRtnyGk7iL/qPh8tcFfjg1pKtu1+LyNJ3paG0KRi+jyNg/FkJjz3flCyAkbxtiOVjijXU9Z8GzfXPHcRMeBF4MQFpKgME30o6rIpzXuAbGPt5bDqM+TNQiixANgVALXHBiHDA6ZcKrP/5EvoJ9c0s5+MGt3Hbtr15A9oSbGI5I67s7zF/pndNHi+BOJHHRO2L/WqJZCU8SgI8FBr3x7DzbJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN6PR12MB1410.namprd12.prod.outlook.com (2603:10b6:404:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 14:11:35 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38%8]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 14:11:35 +0000
Date:   Tue, 12 Apr 2022 11:11:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Limit join multicast to UD QP type only
Message-ID: <20220412141134.GI2120790@nvidia.com>
References: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com>
 <20220408182440.GA3647277@nvidia.com>
 <YlLHjFlR8BtCc5Hu@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlLHjFlR8BtCc5Hu@unreal>
X-ClientProxiedBy: BL0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:91::39) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651122e4-839d-47ca-e0c5-08da1c8e5a5f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1410:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14107A462CC4D7A78F157376C2ED9@BN6PR12MB1410.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RomV7OHbBqNSg48q/z4m+RfDRXuy8WUxscvD6WIMto8RU4tqDVaZGc8STza0hcpV2ng10rnLvP4SnS+XRhTiNYwa4xBJymlRAxYDM+Rvn/zC/p5xCtA5hbipV+3gzNNNB06bw9DpFSYKVeb/HpJWd9XBOVRPVIzQngAg7UKQqrT4IS/E4ZxHBosI+gbsTMoX2BBMIveX92OyCPvoDEgZ6Y0P5W8rRp3uyIKEMFZtalqimtLV0CZsDw7vFQ/kdP5yrphOgphnDjb3nN5XAZ+wTuvr58cTbK7ENYJj3ZeHjPrtxEXWOxlWlmQCek4RiAwOqNVcrxgd3SabP4qYAQHdxzMYT03vy9qC852MaiRlV8/O5g3HrWXwcGF+buPz+a2E2vZz5q2O5le7+wBoOLRsnkREStFnri36W/pg8L3u+RRN/Kz7VqG5MZoJ2GF6SmjDV8qnMO7+IXj0+A4zsnehY3mVx95Q7XEZnNbPv4c+VQCX5dlkMcWnAAvAL8tKccVWjSLpPxU2GFHalifCR04ahPghQ+qkpHH57Ez48144MjSgJqr7m/QTxATEfcT/xZhmkVOrbF/Iy3S5urdKXJ8EX1EqJ1w6GFoEYzhF4K+wsf+s3PUIH3O2eF1Smzvk7miPGz9BbGFhv0Ok+hvM7w2WpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(26005)(1076003)(186003)(38100700002)(2616005)(8936002)(33656002)(508600001)(5660300002)(6486002)(36756003)(6916009)(86362001)(316002)(2906002)(66476007)(66556008)(66946007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pytf8xX/tEiwYhzfGWOPnS73iNiWLv8uMJC0k2Bj/jLOEuxgdZgpSZoNNhz9?=
 =?us-ascii?Q?eb7YqEMknU+PY/V+67J6IPnXtsNLc6oIGw5gmXe0EHZZR6Mwt0DUBP77Yy1U?=
 =?us-ascii?Q?uAtHeIKwIvgeKw+fHjfaYPllnSZozVyt51HNe8TFPrZuBKo+FLZ0pvi5w6ZT?=
 =?us-ascii?Q?MXiYIyzd7uDTt5ymu5/YZC/4WbgVW7esa3gpv136q1NGUlbjaKC5iNFXpR0w?=
 =?us-ascii?Q?8jfUIom1Z+o1UCyY0YAoaNugGdWRcP8iU3L+6eV2VigO36aIbNtnuizW81h7?=
 =?us-ascii?Q?eOxn9Bx/QnWD8JJrMxi31teGxFlJyxcPQ/RsPEsfYowYngzvTxWuXByfB8SN?=
 =?us-ascii?Q?lvol/rCGtX86V9zaz10ffVlKKE8zvs7YhCEC3HkrD/S/Bq31jFKD4d78QvTj?=
 =?us-ascii?Q?MD1Fkv8Kv5IbdIQQ9sfCTjlbM9ZDXlI0FHggTUM6Yx6mXpSYtyupaOpccdkO?=
 =?us-ascii?Q?GEL0TdM/OStQQ+M001tXiT8pXiwBRjevRk2plcwEw0p8S/S+pmZ+kMpzT/6n?=
 =?us-ascii?Q?8O8SSndp90msG7/LPfOAHUwFx+Dso0xFbPC3rWH30y0mef+8c3kSmmIyRZyR?=
 =?us-ascii?Q?Ih1ScOqjoVhwKBQOlMAK/ynmT8X0awCdwxDE3S96xj4CidCpAJq2W51nuIP8?=
 =?us-ascii?Q?B1wPuwrYkotjMErXBYimh2mkEi80cdR/6H1FdbALQPPmSCGW8Fljby3I0jpW?=
 =?us-ascii?Q?a+YD4CLUgforsWbXbfn06VerZqQpRkkWl2Q8jxb9pz/t+IiTUk/kUuDvULr/?=
 =?us-ascii?Q?NPZMa+lLWAaeosgPyI2YDP94qbfEjzU0voVKrgy1mWfOdJ6kTLl4EsFBGSXv?=
 =?us-ascii?Q?YpeexI4huEwW1QGUciz8KBWy+UsyyTPO1qAIaqqf4er//34eG0sIK/zel0Cs?=
 =?us-ascii?Q?3RsgiAm5o+ViOHoD1FLkHk2PCbPPdq/mAJkQ7QIPcVv1+Tm4EkeIWsTJvKGx?=
 =?us-ascii?Q?NW/yYytMVUETVuj+Mg3o5wB54lagf95i/qtsaQA5QKdaEhruycJHn9SEaBUh?=
 =?us-ascii?Q?UWI7ydUTSmOjOCaytvGaU+xQxIRnO96Ftmq5jotgx5Z6lS5GQAvmVVIvNlkK?=
 =?us-ascii?Q?7yAVGfgYaRDymbGc60JphKMfYAeoOB+2DXMo82VvcORTD9mbVnTi5vnK5Trv?=
 =?us-ascii?Q?5PnJ8CVJFvsNLJsGA6r4b8Wj/9QUGXW316PBYu/VWkCKQUPYuc8jqQxRxA2R?=
 =?us-ascii?Q?n/SyBaT41mLsBdhI9tpEEtBnW+lEvh6rBSI0j9CipOQk+lacwgGp7IpEblh4?=
 =?us-ascii?Q?tHdcKccHz3njgn7Nnkef29TR99YR/9ZZXROFZcUUlZECPgG9N/jl0VYltQXn?=
 =?us-ascii?Q?F/JDO6PXjwNoZzPn0rJlZ9yTaYf07oHlmXoQ97CPVY7xYYRSm/xmwASAG5lc?=
 =?us-ascii?Q?lhIA8ofPiju0KC+B5JOLgJLYIjHyS/nZv+Vk9lOpbcXTNj7SHgE1F074zgVV?=
 =?us-ascii?Q?ErpF5BLQKlv1fx+cYRXOYGGQZGs3UEEMJ5rZ/4mXN7l5pIX5aB4nvmWSrFYf?=
 =?us-ascii?Q?z43MTJqhTN2FgeMnLFRSx2r4qt4Mr116Va+hNo5NO4Gj/UZLpB5CuSVdzwZK?=
 =?us-ascii?Q?ojLkN/gN3EeaF0ccX1VIQ89YViq2s1NgCrDdm2jhivcceHnAl3Wlg6KxZEmk?=
 =?us-ascii?Q?D4gY4fhjtTEGjJOas1IitoaRtEqp+v4ng8crCZelsJhAOtbTOqyBMysJUVy8?=
 =?us-ascii?Q?2y4YBzjElt99nxPkQ/e/JZHu0zxlR+qSsDphDynN3qEsD2vq5EyjJeBLoHfk?=
 =?us-ascii?Q?ZQ2iU3NNpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651122e4-839d-47ca-e0c5-08da1c8e5a5f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 14:11:35.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvGq9WMDftvbNidYWg5mFdXwUg7yDnqzPg79DOnlTTQmd4VX6g42qPdaqXaPS5/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 10, 2022 at 03:03:24PM +0300, Leon Romanovsky wrote:
> On Fri, Apr 08, 2022 at 03:24:40PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 04, 2022 at 05:52:18PM +0300, Leon Romanovsky wrote:
> > > -static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > > +static int cma_set_default_qkey(struct rdma_id_private *id_priv)
> > >  {
> > >  	struct ib_sa_mcmember_rec rec;
> > >  	int ret = 0;
> > >  
> > > -	if (id_priv->qkey) {
> > > -		if (qkey && id_priv->qkey != qkey)
> > > -			return -EINVAL;
> > > -		return 0;
> > > -	}
> > > -
> > > -	if (qkey) {
> > > -		id_priv->qkey = qkey;
> > > -		return 0;
> > > -	}
> > > -
> > >  	switch (id_priv->id.ps) {
> > >  	case RDMA_PS_UDP:
> > >  	case RDMA_PS_IB:
> > > @@ -528,9 +517,22 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > >  	default:
> > >  		break;
> > >  	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > +static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > > +{
> > > +	if (!qkey)
> > > +		return cma_set_default_qkey(id_priv);
> > 
> > This should be called in the couple of places that are actually
> > allowed to set a default qkey. We have some confusion about when that
> > is supposed to happen and when a 0 qkey can be presented.
> > 
> > But isn't this not the same? The original behavior was to make the
> > set_default a NOP if the id_priv already had a qkey:
> > 
> >  -	if (id_priv->qkey) {
> >  -		if (qkey && id_priv->qkey != qkey)
> > 
> > But that is gone now?
> 
> When I reviewed, I got an impression what once we create id_priv and set
> qkey to default values, we won't hit this if (..).

We don't set qkey during create, so I'm not so sure..

The only places setting non-default qkeys are SIDR, maybe nobody uses
SIDR with multicast.


> > >  static void cma_translate_ib(struct sockaddr_ib *sib, struct rdma_dev_addr *dev_addr)
> > >  {
> > >  	dev_addr->dev_type = ARPHRD_INFINIBAND;
> > > @@ -4762,8 +4764,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> > >  	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
> > >  
> > >  	ib.rec.pkey = cpu_to_be16(0xffff);
> > > -	if (id_priv->id.ps == RDMA_PS_UDP)
> > > -		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > > +	ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > 
> > Why isn't this symetrical with the IB side:
> > 
> > 	ret = cma_set_default_qkey(id_priv);
> > 	if (ret)
> > 		return ret;
> > 	rec.qkey = cpu_to_be32(id_priv->qkey);
> > 
> > 
> > ??
> 
> The original code didn't touch id_priv.

I know, but I think that is a mistake, we should make it symmetric

Jason
