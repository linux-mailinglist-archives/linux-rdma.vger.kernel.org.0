Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6997D29D5C6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgJ1WI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:08:29 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5794 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgJ1WI1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:27 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99697d0000>; Wed, 28 Oct 2020 20:52:13 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 12:52:11 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 12:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOr/DIMCai5G+Qutng/Bvn+0QZzT7uMF4ukC0aKuXucZGtvfPiWg7I1iM6Iq108j5B3K0ltJtgqylVqA6V+THz5Z3OoUTGvnB+MMENIzVMizcnOc2KEiTX5kY3K9GOsFTM/FIQJLDGOnai4er8DUwAf4oFpMBNbMKW4WP/ve0IOU9xwU4RW8XhsJXV81bGp4w+kCjhKAjIJNwJRsV5Z2wlGU/0FJ9516TIipjzo8+NwbE5DZIQW/ohPzqIDy8Mz+xESE77XV+dETnLE1K1ssQCNIRpgehrjdoFx1bIEZ9YSq0rM0IaSVoNzCftRpgGNVrcln4Vp5r5xcCCvV0jfQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLDA0+l/Fbbpo+vjkyVqVJTN/UV2e7a0QqHyot63xNE=;
 b=OMWEWJRpJ/DRZGdJVaAn8v5NBzBk5lXS30cuWQ/gWdNGU76C3ss0ls3WW1TOokVTcteFxzWLtswUdECqdUcRlKIds5As/xEgU9AkcyWi/jbiH66EnBALttTmzmlE8SHesQrcVY/I3IZxVgLuWSEJ4rwefW5TK7HLOXBqUjav6MXPnbFSXJaH9Nzv/V3L3GxeiuM7mRvLD/89MyrAuZ44EDMDfqtFSkFg2FOj7l64TZSM8Pp1Xv2iK2LcCHzWDDVrbLa18KJjnbyIPwQbwgwYTGfEckuH2p16mvLO/o0XN58OclHEkCu8tD/xBsl4gkjOGZBnLTt3Flp49lGXQSW7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 12:52:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 12:52:09 +0000
Date:   Wed, 28 Oct 2020 09:52:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix entry size during SRQ create
Message-ID: <20201028125207.GA2394782@nvidia.com>
References: <1602569752-12745-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1602569752-12745-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BL0PR0102CA0072.prod.exchangelabs.com
 (2603:10b6:208:25::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0072.prod.exchangelabs.com (2603:10b6:208:25::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 28 Oct 2020 12:52:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXkvv-00A30D-TP; Wed, 28 Oct 2020 09:52:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603889533; bh=wLDA0+l/Fbbpo+vjkyVqVJTN/UV2e7a0QqHyot63xNE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FH92RoM0oUw3t8TQ1rUUdR1Tp7u4JpTby2jWLulYEfYRQSP7hLphQ9r+p4NcZjK7C
         UbEGMyA0+Fb9drmGFuI5/Bz1bQki3jTJu6EMgFfaM/bhRL3WCncBEEtwAdK8wB92uI
         tjFDgekEhm33DSohw8VeNHh0OKdu97sj5+3IutrFsxzYIkMa8yWc5iBmhHw1K1Jvhw
         YjhmSJXD6E+upQfUScRW0RuhklrXViiBCWROu5J7BJ697CcJ1fri00xm5LvPhtR2iP
         qG3IDKO9Cxz1cbyvbLBGzlJ6SSEv/UWUynmqBomy4hOyrS6+pK/2pKPODwARpKJAtu
         5GaarIEL/boOg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 11:15:52PM -0700, Selvin Xavier wrote:
> Only static WQE is supported for SRQ. So always
> use the max supported SGEs while calculating
> SRQ entry size.
> 
> Fixes: 2bb3c32c5c5f ("RDMA/bnxt_re: Change wr posting logic to accommodate  variable wqes")
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
