Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E3315776
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 21:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhBIUHh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 15:07:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6210 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhBITyr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 14:54:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022e85e0005>; Tue, 09 Feb 2021 11:54:06 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:54:06 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:54:03 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 19:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCgvfKjysIgXie+LjLCOukAbDWmqFH/DxhG8gqUSFJ69fpW+IgR/sJdXjNceoZocExntrjOviJDSpUFpOzKo/p0zSR/iFhDejsLHg17G5Q/kkaVn+rowltLVQwBACMPQQlmqBSK9GoNcLzxBJn8Jt7p0yS5x3u0NXLvwAWyjMFArwvzkGgi530xDSe0+RxdllgZtQvylDx6wv2grJ1I80l4ZxE5UdneOnMotrDBzTlENtUxl7sk2niU+MAWv/eZ1VlQE5+d1mATvNNvVtbedje/1GJ1qjDito8WwF8W7IF3iHylk+R21X37EzSUT4rE4El8NO7diClGaOAeJv/wujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPoDyMvfKZrL6Mf4f/K2Vhw8gsG76zx51uuX7QJHdQA=;
 b=OynUvRCniBiYaJiLGCAWvmVedYNsehekmhoiktpgXhmEZBOvqaudHKEfBIb4SIwP9inbSgu4ozfruR0FxK7GGqB05JwGgzxthPqhAb0j6aVkmCt3+0c6KMwvopNjAsKYInk52qWZwbDNhFT69SfSAjachlpIMW3mkrJ150NpQFokWnQl04RdyrS8Rg2I88Qkoq97H7FjUDwhe/ybjUDXQ8kr8ySM9RcnDizunJjkT4WMj7RVkeOWQ2S9vEWsFOPhfu1beZXy22hbHlGyyR/T19XDdETH7Fh4CnlKEPckBDFxl1BT8Ye1lgcxB4eHW4vAlWzFRCxjdbh8P2R9ZlZwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 19:54:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:54:00 +0000
Date:   Tue, 9 Feb 2021 15:53:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <leon@kernel.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Message-ID: <20210209195359.GT4247@nvidia.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0105.namprd13.prod.outlook.com (2603:10b6:208:2b9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 19:54:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9Z5D-005cdG-6y; Tue, 09 Feb 2021 15:53:59 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612900446; bh=QPoDyMvfKZrL6Mf4f/K2Vhw8gsG76zx51uuX7QJHdQA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=cuJUZy9E+QGdHB3i0aFeCXYvVi8WhjXEBYp1N9+1j2gbjymiUBTqoSlCIaeH4/OKY
         FCd56bvk0xrMUjZX0+TVNTjli3QVO6sDmwx4XOwmutrk0ol3dvA/XVLmSEcHpJda7X
         xTQMeK2LOjAHM9lVjCYKL23f0flaEEAi41XDiMATvL98WIYysJz8BQIamgoAEkq+C6
         1isdSfuG2GnocjjjleY4dtQZ3ENYb/GLfAPaiO61XTAA5rwLqt6OuFj4LNNk3qrvi3
         x8WnFosRhPibEXTWXILztQej9HNeZd7yNUR+p31z+O6m2tJKDE8+lhb0KWUDqfpxym
         01dyQiyOuF4hA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 07, 2021 at 11:12:49AM +0800, Weihang Li wrote:
> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.

One a WQE buffer is allocated it still acts as a normal WQE ring
buffer? So this DCA logic is to remap the send queue buffer based on
demand for SQEs? How does it interact with the normal max send queue
entries reported?

Would like to see proper man pages explaining how this all works for
rdma-core.

Jason
