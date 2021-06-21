Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385063AF957
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFUXcI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:32:08 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:21984
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbhFUXcH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:32:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avo16fqZgpUHyi+ybjy4HMWmhR169coJwwI+e18FK3rve0WaJV5eHZ8YyRoGFKNJ14A7gii9QY/JAMm9kPRqRZqfMoViFs4xXG6D98j/yDFMOvToRj/ds2T4s5YLdUBFc8KGcJgBmgtu/JVJUJ0hG1S9a0oaiiuI57aoZE/5gjnXbNHaH4K+AMmVBPzz7VxUUMRs4rtmpgmepsy5hB+aPYpC/PBfQPHuK43ZsRVZGVJMHWhLQPzkywI7bw1PO+AKw/UKzRTdw0j4837mrH9j6ttEt6ZyuZrNgEyMD0KTLUNFyPXpkEzGBxdVvGEYzfS/CwekhY7oPfW+c2TPgz/TTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJWLQS2tZnKKT2wYXHm7SB+x7ZNijDh3TZN2yMsUe5M=;
 b=WvdSkoFn8jjG9ncFcgJIj+lOP/+ZNJvuZh4eJ/9hGyUzdWi4v6KK1RXuezQpHgZD20r5AG/fkYnRr4OOfUjoQJkztfRaDB4cuS5/TDJKzI2se2XMrdVPnSOCDQyefSolJktznt3yA/OlmlGR60UiQxEgNaV5t8lWXU4s1iUEoHNKjAYbAY1obDbHEEIro1t4oa40jSsnAmLUNO7SaI45t1No+avEpyM+P1JkJ7FjlzVTlqAUnGD+TouZAFkTKClS5zdo0jhVKz/NrSIt6/7BO23cotkYNrJ4mQBWh+8lm4JMlzGhlFh6tk25vsbXEWi3Kf/QFLaKH2KGGto6hS0Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJWLQS2tZnKKT2wYXHm7SB+x7ZNijDh3TZN2yMsUe5M=;
 b=NubW2U7LjTSDwy/HU4OHJ0hGV4QJBPA+dL4xwFtJUCEtCb/mWqf0PBVx11ibl4Um9QMd8vEqNNU1TmnjIv84EYelK0lPRCOmXtyCDfKjnToFWnQVQ7P+C8CS2SZCDbLqT9CffzIvYL7NVuH6Mme1BSadkFSaYLjESZbMLUXZUrA4toLT+pLAi+G2QhiHNjCaq2k6J6oEPPsDEdkn2JDUFZN68u6HSGfTbytnNAG43m75djpdpHErpUMD6/4r74zc2LkEmSCVy7bbaFPkhBVxVgDnBi7LpIQAwMWP3LNlZxTnp5OkTSQ8QFFL/IumUGwBZXXkLtBb9fgCypYZk7Cc2A==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 23:29:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:29:51 +0000
Date:   Mon, 21 Jun 2021 20:29:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <20210621232950.GU1002214@nvidia.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <20210621143516.GO1002214@nvidia.com>
 <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
 <20210621153255.GR1002214@nvidia.com>
 <E45662B9-4E10-4620-9718-F11BBE36AAE2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E45662B9-4E10-4620-9718-F11BBE36AAE2@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Mon, 21 Jun 2021 23:29:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTMU-009twH-4o; Mon, 21 Jun 2021 20:29:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a0837b-b130-4652-9fe2-08d9350c77ae
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125167FE96FC3EFECB598B3C20A9@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkqQmuHLOUDoD4NHAUPij/uRbz1QeHLsgGNGsRecIXruyJi0D9gw3KyMkGu3EXDMda3iH0i+dsyLy7piaUJRNczdSZO8SAAJGHcrBX9nRZLTHYOJu+IZxum7MbdwX75pwfOGmY8op0yQ8ZzPfrLoTsaC5aQNMvsQAolviqkUp1TUg4rH3e+dbLoiuGNLXHIUhVBl/xpbxhFVND7P1QDUJXeSN2F9fcWrFbxPKOGTysB+KTLZapFhuUmmJ993fidNfw6JuSRmpp3+PrEJrBW/d4ScgK5UYJKUKEX4YzLXcMHvx5Tx64JUOJcb8PBurQYrfr6Mo/iQIOm8ZPjVFEOx0nDMjpLslScvzIXC1NAhnheoUcdVotOzllVdZtw7WJuiONff2OYXS5XjiAzG0ImS1KPdCSHMS6iwAKHGMTCNVElRr0YojopRj7VWTBfs+mb+FFbaYX1htAV/u99f/vYwvW/zCn++KZpdMjgIU+PX4ljPc7E8KiBq0bsJ0fi+rMc7E4dBUz0Os9kylSt0RokZcsjPecLtZO4gtS4xCpy+uqWT7VrA1Qc6p0+MKpIf/8HdjUGUneWkGHW7Rlk8q4j+r1rul4jmtaSCDmiQwgWpWMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(66574015)(316002)(478600001)(83380400001)(86362001)(54906003)(9746002)(8936002)(38100700002)(426003)(2906002)(33656002)(4326008)(53546011)(66476007)(66556008)(26005)(5660300002)(66946007)(2616005)(36756003)(186003)(8676002)(9786002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFIRy81ZWtBZXZucGcya1V4eU9kQ3ZxalQ0d0t3MDVLZmp0MXNFcVAvQjNy?=
 =?utf-8?B?eXNyZ3c0dzhxcURleGxBVkQ5KzZxeGVzeXZueEFXUWUvUXVaaFpYdFkzZzBL?=
 =?utf-8?B?RC9OV2FTemRLdkhSTkg2bHg0Skptb3Z6R21nSmZCOW5IKzB3aFF2Z1NMaHd3?=
 =?utf-8?B?WHEwZDBwTWI4bXpKOVhydElJWEhuaEM2Qm9KUVk5Q1g2NWpGT3JUMFc0K1dM?=
 =?utf-8?B?RG13aUJ3dVpBcDluK1M1ZnMyaUgxSzU0ZE5MNUpvTHJmckhQRnhYdlJDNzRo?=
 =?utf-8?B?ZGJBb1pIRE02ZFhsVXZMY1hzTERwaitLdWdsWHY0RnR0NE5lMEpwRU11ZkUv?=
 =?utf-8?B?dG9pbWtmckNYZW1oTnFsMGt5b2g4dFU2TnhmTVBLV08wMFpIWEFld2pPSlJq?=
 =?utf-8?B?WFYyMFJ4WkpNenBPL201enZsN3MrdXhkMDNTWDFpSXFLVkg3K2RtNzlycTRy?=
 =?utf-8?B?VVZZMnlPa0VZdjZZdlM4M1lxVFlEWlh1N2JoalVkSVdoZ2JXamNieklacnp6?=
 =?utf-8?B?TWNHdWlyS0xLNHp5MjhFQ05PcERyWEJiNFVRVXgrUHQyVHdYZS95c3dkUzVE?=
 =?utf-8?B?eXIrbG1haHZ0QmZjejFDc1I4TEpuQmFtN0hPODU4c3Q5SmZ6eUk2dEFQUmtl?=
 =?utf-8?B?ajFlZFJoakdzNjZEbHRkL1pIQTZGaTRJd2dEQUF6RTB2V3NjbExBUVFBZERN?=
 =?utf-8?B?NWNuWUY1Rjd4ZGFEbTR5NzJ4Z0N6bkNXQjlYUTZieE9TRmVmeWRjMjVpWk85?=
 =?utf-8?B?VW5NVUgvTFgyZm9TS2xNZk80QUtUM3RxNy9McVpmRWU1MklEYUlFRWhvSWVi?=
 =?utf-8?B?N2lpb1lDc2ZUTFRTa25vQWF4a25HMEtjb1ZRelhPd1dDYWhERnRhMGl5NjZG?=
 =?utf-8?B?cGt4cFhUZEpZbjRYOGcvT1Z2WktkVnQxREw0dWVGT1RaZTRSelFmOU5OT3N5?=
 =?utf-8?B?QzlFS0RSQy9wVHJjOGVoTk9oNmJNMktyOUV0QlZ0UVNhMHdzZ0M4b3ltNEM4?=
 =?utf-8?B?WmRsQUJib0JKWUxrcjRiNDJOOE9CR2dISVRrR0hMVDd2U2g3WVJvRjZUR2tS?=
 =?utf-8?B?MEVBMnZZV093Y2VxM0NqS2p1YTNaMXpKWjBMTUc2bS9TaFZhNCtVK2tURWVJ?=
 =?utf-8?B?eUJaQmVQaklhWVlSMXd5MjFmSXVheGlpTUQyNlV5TFB5b2FBaFNPYjMwM1oy?=
 =?utf-8?B?RDQrQlF1ZWxVVlFteXN2NXNFVmFxL0ZvdUVMTWV1WVo3WWJuQ1lKNlBYWUhy?=
 =?utf-8?B?a1FENG5ZSElrdUVEZDQxY3puS05rSXUvbWFuSUhHQ01hdTZjeURkZWc5VjBB?=
 =?utf-8?B?NzJWTXZyQ2s1TFAvK252a0dXdXlKNEFHVEQ3Y1dmcEMwaFU2TGZHRkIxVXpI?=
 =?utf-8?B?TC9KYVlOZGhZQXB2N1plSDdCUGpEZGRWRXF0M0QyTk1CajZ0MzJDcUZaV2xx?=
 =?utf-8?B?YXZINjFNRUhiUzlvTW1uRkJyeks5R0U2dHRhY0FFbFFqdFhRakg0M3pqcXpr?=
 =?utf-8?B?WWR2cnh4YWF6V1Ezc1pQdFJFNE5YWUdqSDFjZE5sTVJTY0RteC9SVlFEVlhm?=
 =?utf-8?B?TGhUaDJxaThJZGZWUld4MlM1bjRvcHRHVE9oQ2NGQlpTQTMwU1ZqYXdrR1dU?=
 =?utf-8?B?SkpjWmR2a0t6aHlkSS9FemxlZHJ6Y2xHRTJ5REtZVS95NjI1dVcvVnlpdlpS?=
 =?utf-8?B?dkI3YmhVY0VxcFpMS0ozL1JGTnFqdFVRSWFybzh4NnNQY2dZazh0Smo0ekll?=
 =?utf-8?Q?0v+lf9wVZrHoftqaWGsLL/qCMQz9hCw5Z6z8EUR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a0837b-b130-4652-9fe2-08d9350c77ae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:29:51.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /302GtaVNCbasuRAAu+dV4lVK/xY19sdLfgATo+UgHHG5ILOOKGyvPEl+N7qaOnf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:37:10PM +0000, Haakon Bugge wrote:
> 
> 
> > On 21 Jun 2021, at 17:32, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Jun 21, 2021 at 03:30:14PM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 21 Jun 2021, at 16:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>> 
> >>> On Wed, Jun 16, 2021 at 04:35:53PM +0200, Håkon Bugge wrote:
> >>>> +#define BIT_ACCESS_FUNCTIONS(b)							\
> >>>> +	static inline void set_##b(unsigned long flags)				\
> >>>> +	{									\
> >>>> +		/* set_bit() does not imply a memory barrier */			\
> >>>> +		smp_mb__before_atomic();					\
> >>>> +		set_bit(b, &flags);						\
> >>>> +		/* set_bit() does not imply a memory barrier */			\
> >>>> +		smp_mb__after_atomic();						\
> >>>> +	}
> >>> 
> >>> This isn't needed, set_bit/test_bit are already atomic with
> >>> themselves, we should not need to introduce release semantics.
> >> 
> >> They are atomic, yes. But set_bit() does not provide a memory barrier (on x86_64, yes, but not as per the Linux definition of set_bit()).
> >> 
> >> We have (paraphrased):
> >> 
> >> 	id_priv->min_rnr_timer = min_rnr_timer;
> >> 	set_bit(MIN_RNR_TIMER_SET, &id_priv->flags);
> >> 
> >> Since set_bit() does not provide a memory barrier, another thread
> >> may observe the MIN_RNR_TIMER_SET bit in id_priv->flags, but the
> >> id_priv->min_rnr_timer value is not yet globally visible. Hence,
> >> IMHO, we need the memory barriers.
> > 
> > No, you need proper locks.
> 
> Either will work in my opinion. If you prefer locking, I can do
> that. This is not performance critical.

Yes, use locks please

Jason
