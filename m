Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85EA290CC2
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 22:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393345AbgJPUcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 16:32:01 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:33929 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393329AbgJPUcB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 16:32:01 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8a033f0000>; Sat, 17 Oct 2020 04:31:59 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 20:31:58 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 20:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5tvfSYjFThg3YKNijLaYZrMCiiVrwfsEqHmNaaqk3DZwGuejqmbGgErJoE+uXBrGAGja53ttuxBP7bGj38r0z9r6RmB0GkOZQeMqf6MaW01QPbiE6Z1E+K/QOSOF8miWw0WhSxuKV4WA+gB1/N1D1cBcUxmjL1/o/y9Iwd+r6zwNHQlHLEL+r5pRHa0olNKDBHEqCGPnwo0plcYyzK60NxzNNuyzP/UeYoaHC1bnRRhU2wBvLK+J4wjZir/0LtTTTAvYs1lChui8sXGm9bYaRYU+5V7UZyEM8Nxr31t4HTnk54p49f/ixrOrhmtrYkXqsSCUtA38jfyqvZiixJAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+bj71lqXBq4tieb5p77Pewdo7clRpLS8OHDiWVd7cI=;
 b=VDkGS2JKOUwmcybTx5JGmN9y4gc6Tw1cfVbP73PQ8efB0EziXvRy3XVRg67OTWDR+opwx6mtjJJggPk1WudiZZf1hCM5xJ2ToO22uEMsYgJ3DSE3HMj4h4ugmTV9bXvHEqnTYt8lkW+V5I2Vvsfse53Fc0lAY/fyHYco1rNf/OmDvrNdYsQ6kTFQuioqaaW5MAwcmjzFJXe2+HvnXDWjWdiQThKeSCgvDxzLQXl7zdsoX446T+ZQvk2lAKHvDPxER+Wf330llGe5MZ4c5ghEXA+++DrRKQbuasSMrvvZZaBYD1SEKDlpy5W5GD7D71HaqTWFsg2pOPesSOzjh/Mgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 16 Oct
 2020 20:31:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 20:31:56 +0000
Date:   Fri, 16 Oct 2020 17:31:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: Move the definitions for rxe_av.network_type to uAPI
Message-ID: <20201016203154.GR6219@nvidia.com>
References: <96dfe365-bd38-4022-8019-e337f168af47@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <96dfe365-bd38-4022-8019-e337f168af47@gmail.com>
X-ClientProxiedBy: BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 20:31:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTWOI-00107v-Sv; Fri, 16 Oct 2020 17:31:54 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602880319; bh=7+bj71lqXBq4tieb5p77Pewdo7clRpLS8OHDiWVd7cI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=PnAC8aBPOdHTepMmK9IJ6qpbhgebdaOHi7KMsOI6l1hckH8w1HThwWHOG8i6cvOSY
         4G9iqHorQ0zeNvHPCba/CjNV18Dg1m+A4WtjYauuiQzi5Hj4oWwflHHWArQko9m6yH
         fosrCxuLAkL9uwIfvcQouGIHTEsh87E6INTpI2MUNlI/hqdFa70sy+BNQOrjy/HP1o
         KuH9IE4jgdRDHyHLAz25Of3WruWhQgRJ+mEcQO7FukKx46C6Q0zZnyJ414V5jJBCP0
         SOieImaEO7jKJ038+orwKRU/DmU5yuoikxttohJn9bcRmWdJ8BCV4vDGaMo1k1H/6r
         BsURetT+ONVfQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:50PM -0500, Bob Pearson wrote:
> Jason,
> 
> Your recent commit:
> 
> 	commit e0d696d201dd5d31813787d9b61a42fc459eee89
> 	Author: Jason Gunthorpe <jgg@ziepe.ca>
> 	Date:   Thu Oct 15 20:42:18 2020 -0300
> 
> 	RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI
> 
> has some problems and so far I am having trouble making it work sensibly.
> 
> What you have done is to make the network_type field in rxe_av be private,
> (i.e. RXE_NETWORK_TYPE_XXX instead of RDMA_NETWORK_XXX). You then defined these
> private enums in rdma_uverbs_rxe.h. The problem is that there are more than one
> source of AVs those:

Bah, I missed rxe_av_fill_ip_info(), still it should just transcode
for now.

> There was also a confusion between V6 and V4. I will submit a small patch that
> fixes that and makes the enums the same again which is more efficient than transocding
> them.

Bah again. People need to check the stuff I write at 9pm :P

Jason
