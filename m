Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB42A2C37
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 14:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgKBN7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 08:59:38 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15452 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBN7h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 08:59:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa010c90004>; Mon, 02 Nov 2020 05:59:37 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 13:59:32 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 13:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVuilbOKfbTzqA0BY1KEg0pK0qI4yaW6cZWIzL9z95k8xlgw/T5yC6nX/coD4PAYOtTlyBdF9lmH1T0BnmN5ypSMG+/1VRjlvZrUKP65K4MWT0stk23thllp7WeM/hqVZRWIHVQ6IoArMQ8K+pOiSk7Zpw6Tsak7JCDLtgfEvW4dwvTSRQgNKkzN6pB/XV/63w5tAshYMKNgffsTnrQLiQflbKIwTONsTMxAXbGKEDTKOoMSlhnjm9ahY3grptzryW/ah4XBnnM5h9EGt+2ZV7ccS9EtriBjwXUqVO4drrZ/pmy9HlBY26wOwNDgzNYMkskugP0z9XhaUtjpUrSlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaxdqnV+5NJwAbgGUQjEwpfZT9xii7YG4HGl0P1NCrU=;
 b=JrP9jevNZx2E8n2rlujnM967GA3QAJEh4XWQ0lmSzlRBvYjTUMsK/iN9CkKIKDN6f2VlL80EbO7hkAbotECeDFXNMGEkYg6giWSUNzStFvhKwPZSrL/BY9EhmIgTneWMnmrFKeOgTCytRpvl0rX709OYagb/cetXNrXoGEz29bRP16C3nU1S/GgVmwdjuc2yWoue4oSVEyjOYCCUSXe4GKjnA86EItk5Zc0fhdQy3x2J1CIbOVnnOXHbV//T+TLifI3KIa8vzBbTxz6KU/8rghXKoZVyVM3IF1viBBb6tQdKYyRTk25yAWsnHcL2vVp+JZId7fDwoAaZWZWwx/+ekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 13:59:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 13:59:31 +0000
Date:   Mon, 2 Nov 2020 09:59:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
CC:     Yamin Friedman <yaminf@mellanox.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg+lists@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
Subject: Re: [LKP] Re: [IB/srpt] c804af2c1d:
 last_state.test.blktests.exit_code.143
Message-ID: <20201102135929.GD2620339@nvidia.com>
References: <20201102140235.GA20030@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201102140235.GA20030@xsang-OptiPlex-9020>
X-ClientProxiedBy: MN2PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:208:134::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:208:134::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 13:59:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZaMr-00F6fG-FJ; Mon, 02 Nov 2020 09:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604325577; bh=eaxdqnV+5NJwAbgGUQjEwpfZT9xii7YG4HGl0P1NCrU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=LB4gcr8hwZPHxMgcy1rcJMJonJkcgk9bz4CCp3CsRC4kSYUELG4zDq+wpiZqcDj0h
         d5oOC0AmIPTGyTdS4qYbxoXeErNdQqI+YsGPHVLkitpPK4CdaTNIwuqTUNegU67CsR
         4y0mHe+v6h8HypyPDrLL5Xlc0foNESORFwCbuWjh7ixq+KKtUWZWAYqQWEqD0CSUEH
         rzCps2LuEMpQa2ja3+k+71mUjpd8ZVUsPSjByyOwK8FzD8APhSY+hkMDxNySVjXtwf
         a8MuJSFNc4273anBuhphZHE4F40dvdesBuainsdJrOroPnkuz+LsfPl6gD/a3dpQ/E
         amZB9UH27XHNA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 10:02:36PM +0800, Sang, Oliver wrote:
> Hi,
> 
> want to consult if all fix merged into mainline?
> 
> we found below commit merged rdma updates into mainline

rc2 probably fixes the error these logs have

But I think you'll hit a WARN_ON that isn't fixed yet

Jason
