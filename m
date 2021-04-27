Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BFC36BD10
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 04:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhD0CAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 22:00:46 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:59887
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231128AbhD0CAp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 22:00:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu2eFcFUq/WDwLLuNKgVeXJ3D5EfOIPYbnp3FR2zxD77LBA0mwQ4WuT6vlpw9XutJjdtuLcWbsb9LxOUandxlbb+t03rWWE1kZtoref2DRImTBBpjfdysTQl9AroggQtSVZlG+aLI7CJ3vPwXX0SnMD8A3mg8SgN92IvmfKp2efjPE2b+TVLoKEgc3h1wLkRE/LT1HzCZ8OJPHgoxJ9B7KsgGeIdMGSQz6mztnoA0jOe3JjckEVEzpaKQmXLk9+OJEfotGHFpR/rnNvp68JY1FGBBj9YOn+E2l2ELGDQhsNS9TEBlLuEUPM8+f5a800RnyohWgx1Zzro7Mf5eh28Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geMgtCiEVjOzkVNGKRgNe/YeyS+ZQum+KDQ24MCO0G4=;
 b=MXYvywh2kAwpKKiLEGWWCNfIPQ7gqFWybNz/g9JaarzdYD8XtuIfy73IRECtLnCQZTpk+7du30avrVZmao04gXs8fBhPso6idLalC3jTNTJqa9GVTQPlnBU0DGZoSBHFA2vo3dXXFaCgqpdTtwVYlThQx1ajbXLPlSbXDSX1RjsohWj5tl21p/iyRrf7fH9OK8iwJGH1EPkQRVYGF8OtYnX6TNG5QcajRfaTXq+zyQqfclOxkhie16hKoRdVdcQ07jifsncaYk/OoXfDAG2h0VE6SH+JQHF4Ky+82yqYUbjEtJ5zWB+PUHkzzIjZoxiPAlHUlr8WzkdhcXPtrXRUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geMgtCiEVjOzkVNGKRgNe/YeyS+ZQum+KDQ24MCO0G4=;
 b=NLRepj1sppWj+h/naaMKUi6hAODOK6u6uBXc+gGz6egL7biFnFl7S+RN24VgPFr1R1IsaXljbmtwgh9XiZi0+pRdm5+uLQde9wG0KpZC/XWZXjJ/Qy+0ZT/rPJfrGOC6zYQzOufDsMHIB5IfImEurpd3fNLycIsQ5tRLwfsTfmVGAlhZ7OdmFGlgNILX2jH3H1SU8NycUzULhxDtSDYk4OW4wmUvFMLkC6RGR9fUMP7nYeFBUz0VPgEHJd/MXjstKy01EUy9natwZzuvm/jACh1Y5szM9/PwgU/qKF8OPx1UzqvPIvtSkW4hhp0qT/KasD9BM0GwGKqblyk96gNeqQ==
Received: from MWHPR12CA0057.namprd12.prod.outlook.com (2603:10b6:300:103::19)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 02:00:02 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::d3) by MWHPR12CA0057.outlook.office365.com
 (2603:10b6:300:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 02:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 02:00:01 +0000
Received: from [172.27.4.126] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Apr
 2021 02:00:00 +0000
Subject: Re: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports
 when remove a cm device
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <cover.1619004798.git.leonro@nvidia.com>
 <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
 <20210422193417.GA2435405@nvidia.com>
 <2eee42c7-04aa-eea1-f8a1-debf700ad0b0@nvidia.com>
 <20210423142430.GI1370958@nvidia.com>
 <b14de504-52f8-14ac-f65c-bcdcd0eb1784@nvidia.com>
 <20210426135601.GT1370958@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <0884ab78-7a02-c3fe-a3a6-871f5c03e235@nvidia.com>
Date:   Tue, 27 Apr 2021 09:59:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210426135601.GT1370958@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bdb544a-c296-44ba-5d48-08d909202b18
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5112080EC99FB89DBDC5B4FCC7419@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0niI06VHNxIm8TD8hkxPFWOs1biZxsqbRbqbm1PK4lJXVHtVHrrHCmlRC1LL1POSAez8mUO0X8JjPu3pf8jzCm1Q64ywuzFafZkmREstOHoM3mY7udITCQoLYpoyaiCH9vq8orCNAfnkXDcRjT8/Y2UHAZhPZC4ZYRrprvypbU+YkMPRfm0h7pR4EIpsNbtPp6odUGjPiqUmk1wUmZmRzZUy2XkDdSykn1mEaty2ftAF6TFLaEeT41yoPpl9OaTy/dfhMFD3NXEZL1AvoariCrNSiBQhgEVINlYxfsFF/GNRqvmNclDyP1JbGBkrdOqfKYwxHTSD9vODfX0M9Y5HcXwNj6D3F/CSL5QbWW0SHPVInC11kUfgA9WTNd4m2Z8ZQpzC4t1Xb7oB4RIT7jiHkBWB0KgjPaO3LXftu/7dn45hr16I4eLpISiGB3vpPesn4fvWohD0C4Ct0SuMZGbanAD5br+/Zqo3Ffdsq1gn3P/bHhjO/fGnduDkmsC/KRZDsah8LAXTxUgs0QApUNtJNtZGkLLvu0BabQ6H4zclI/T/dWVr2N1btQbO0G6Vk9JG5k2jfAqdLVExzaAcq/3n7WcjVr9QqpnoNEnt1WetlJGCmq3ptc4YFHN94fgG44i7+1scduVLDqdxhJxBdgATVO9C0osJJg82HVdrvJRL+iouabidD7gWeccU99nG5+h
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(2616005)(82310400003)(2906002)(8936002)(8676002)(6862004)(31696002)(36860700001)(426003)(53546011)(5660300002)(6636002)(37006003)(478600001)(16576012)(54906003)(316002)(70206006)(47076005)(70586007)(36906005)(16526019)(26005)(6666004)(336012)(4326008)(82740400003)(356005)(31686004)(7636003)(186003)(36756003)(86362001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 02:00:01.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdb544a-c296-44ba-5d48-08d909202b18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/26/2021 9:56 PM, Jason Gunthorpe wrote:
> On Sat, Apr 24, 2021 at 10:33:13AM +0800, Mark Zhang wrote:
>>>
>>> Set reverse call chains:
>>>
>>> cm_init_av_for_lap()
>>>    cm_lap_handler(work) (ok)
>>>
>>> cm_init_av_for_response()
>>>    cm_req_handler(work) (OK, cm_id_priv is on stack)
>>>    cm_sidr_req_handler(work) (OK, cm_id_priv is on stack)
>>>
>>> cm_init_av_by_path()
>>>    cm_req_handler(work) (OK, cm_id_priv is on stack)
>>>    cm_lap_handler(work) (OK)
>>>    ib_send_cm_req() (not locked)
>>>      cma_connect_ib()
>>>       rdma_connect_locked()
>>>        [..]
>>>      ipoib_cm_send_req()
>>>      srp_send_req()
>>>        srp_connect_ch()
>>>         [..]
>>>    ib_send_cm_sidr_req() (not locked)
>>>     cma_resolve_ib_udp()
>>>      rdma_connect_locked()
>>>
>>
>> Both cm_init_av_for_lap()
> 
> Well, it is wrong today, look at cm_lap_handler():
> 
> 	spin_lock_irq(&cm_id_priv->lock);
> 	[..]
> 	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
> 				 work->mad_recv_wc->recv_buf.grh,
> 				 &cm_id_priv->av);
> 	[..]
> 	cm_queue_work_unlock(cm_id_priv, work);
> 
> These need to be restructured, the sleeping calls to extract the
> new_ah_attr have to be done before we go into the spinlock.
> 
> That is probably the general solution to all the cases, do some work
> before the lock and then copy from the stack to the memory under the
> spinlock.

Maybe we can call cm_set_av_port(av, port) outside of cm_init_av_*? So 
that we can apply cm_id_priv->lock when needed.
