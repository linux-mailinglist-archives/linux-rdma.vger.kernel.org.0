Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5D3152FA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 16:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBIPlG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 10:41:06 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10282 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhBIPlE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 10:41:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022ace60000>; Tue, 09 Feb 2021 07:40:22 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 15:40:21 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 15:40:18 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 15:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op6fqtYqd9AE2inqYmMETxCb/EI8LmjrSpbdzu8EXR1Hyd9Z9wfNu1XiNhws6jH3YBhcF9skrh8sMhIHdtuyUjVF000nPW3FtM7Xyb2iEjvvfiLuKogT5MHBgeGrS99sq/k0amlFpJ/VnTRzd3ZigMQDj0H5QGT/+ZFIdzg51fGqCNYZ3krPOUSMPDsM9HVwBbywEJR+iqm+zLw+KTUlYW1A/ti9bTqxvKd4vT5d08qNDUM1qqFWS8Ch0YoB0C/xCgjJHeM21jbHLnYyJ2bXxxciBt3KyjEJ8lgiE6pB1Gblkz3hIS9k2ist76W31sr1yxmoOJvVUlqOM06WUoD70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwcZbiugR/l2U1kF9fXm7/J5JgAwnEuaLFk8sC75iNk=;
 b=jhVFt3WME7eRJDhqXfigDWCWg83JCwt/US3TheKxVJsouAJqPTcUK1CiPYN2zRvCGhR7wo8QQUxdbUPRRTPov9BDllmMNmPTrqQVKGf7MLCVIgcYAzgnFDwWemR1l37rnlZ807eftY275N8U2ONtuX02TV2g4TJUTyPB1NEPjQ1jpbJqRGJIvPHs2xexqQhADPPmL1eXcdKNRuvvBjotS232Z282hRqMCfl3ZIxhzyL5J6Cdo74vsC4tRE/GMg+4Dmcg8DZxO2oeide2I+BYnlZ+in0vlrd8dKUgXA5i6aRjzJ+PSYUr+5m0CFYicVzE9tKcAARuNOcdQS7DTOs4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 15:40:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:40:15 +0000
Date:   Tue, 9 Feb 2021 11:40:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 06/14] RDMA/cma: Add missing locking to
 rdma_accept()
Message-ID: <20210209154014.GO4247@nvidia.com>
References: <20200818120526.702120-1-leon@kernel.org>
 <20200818120526.702120-7-leon@kernel.org>
 <C69C843C-A2D5-4A17-ACEE-67056864DDA7@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <C69C843C-A2D5-4A17-ACEE-67056864DDA7@oracle.com>
X-ClientProxiedBy: BL1PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0169.namprd13.prod.outlook.com (2603:10b6:208:2bd::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 15:40:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9V7e-005Tvx-3Z; Tue, 09 Feb 2021 11:40:14 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612885222; bh=vwcZbiugR/l2U1kF9fXm7/J5JgAwnEuaLFk8sC75iNk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=T1TNAYi3BdQVsjriAA39vgaufGwM08zcXv9ghRUbP3MzEetjovMDxrHPxQ1tDhX/y
         XvGIAK3cF129j0oLshNNeq1QIdo84nRA9zGqPKujsP2sPwpDef9lDBqzFdx8LMY9zN
         RG3dgL3tPWHyBfKgXoKR3vO3cZKJW0tjd8BxXR/ZrI5aWygn4FJdzVmgPluN9XB53e
         OuKL6IrVjys0ZfKTAP/XeTzT2eWvY75wA8k9xPw/vT0PTCXrkp32mlDsUg1ecGdnAl
         NGTPI3yEFZpyBdFXOl69MMhGRh58KvxIzXffWLa1NhPrxVlAhvZJ0ShAzO0zc6ZC1x
         OLhH3lKvorJSQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 09, 2021 at 02:46:48PM +0000, Chuck Lever wrote:
> Howdy-
> 
> > On Aug 18, 2020, at 8:05 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > In almost all cases rdma_accept() is called under the handler_mutex by
> > ULPs from their handler callbacks. The one exception was ucma which did
> > not get the handler_mutex.
> 
> It turns out that the RPC/RDMA server also does not invoke rdma_accept()
> from its CM event handler.
> 
> See net/sunrpc/xprtrdma/svc_rdma_transport.c:svc_rdma_accept()
> 
> When lock debugging is enabled, the lockdep assertion in rdma_accept()
> fires on every RPC/RDMA connection.
> 
> I'm not quite sure what to do about this.

Add the manual handler mutex calls like ucma did:

> > +void rdma_lock_handler(struct rdma_cm_id *id)
> > +{
> > +	struct rdma_id_private *id_priv =
> > +		container_of(id, struct rdma_id_private, id);
> > +
> > +	mutex_lock(&id_priv->handler_mutex);
> > +}
> > +EXPORT_SYMBOL(rdma_lock_handler);
> > +
> > +void rdma_unlock_handler(struct rdma_cm_id *id)
> > +{
> > +	struct rdma_id_private *id_priv =
> > +		container_of(id, struct rdma_id_private, id);
> > +
> > +	mutex_unlock(&id_priv->handler_mutex);
> > +}
> > +EXPORT_SYMBOL(rdma_unlock_handler);

But you need to audit carefully that this doesn't have messed up
concurrancy.. IIRC this means being careful that no events that could
be delivered before you get to accepting could have done something
they shouldn't do, like free the cm_id for instance.

Jason
