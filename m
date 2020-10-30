Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26782A0B11
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 17:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ3Q2M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 12:28:12 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:11062 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJ3Q2M (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 12:28:12 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c3f1a0000>; Sat, 31 Oct 2020 00:28:10 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 16:28:09 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 16:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsKB/GyxQLMy8cr+vEcpwjEaMT/l1Q0kPskieKGf/F2RDK1Gu4m60hFFJF7ESc65Y/8yiU0uuOREPR6755s9q5NpIShA8nJY1Zxf9Y/eJRH5+9kO0OXP/rEE26uX7h3y91joElcZ6zGx+uot5nFGavGgYbniZEAj6lPclk+ixAVEzyWvO+BdJotk29oQzhK2s1uIFjRzzYy5XUA/4LvOoaeHLzn7EdsxLd6uPNpcEPqaczUXNLQN8mO16ZOYLDZdyQn+zkXS7ScNG4z+iCh/eggxRhxZRbzrSJlCjQGLbGPXRIbI9gYFkg5zMgpflphned0VQ4IO7LIFw7XIsn9CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTCRC3CfJezAc++LiBj+NZozC5+MfvMVVB/odU2TAqg=;
 b=KLixakqk+jOhJkBypebWi0cjA3bJ2oo03NXevbobfx/5MIJDf1ZNpZ3JZxlnSXB7xotZvwio9u0xGXqsjE2U11b0PZ/lrUm4qIQ7L+VwRCkhcXZ9fwMpqAEtl3OwBaQd0CEDNPADLi+rPUjYF/UVJwaCuQGMA3ofr4xWzuxwdlB633de+jtYKvSWOlZ2JnViKVeQY+ADtJ0JbObQ/5btOYAIy06eyUVDvnbQVVpzxI24YJ7CejebwsyM5cQYsfxcpfMtiaVLHB/z4HNMu5B5e5IJBq+lj+seldpGehkfcBwA9OQPmV/dswapO0Zq8sBciLMYgR8ogTN3pfXOPM6W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Fri, 30 Oct
 2020 16:28:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 16:28:07 +0000
Date:   Fri, 30 Oct 2020 13:28:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Re: another change breaks rxe
Message-ID: <20201030162805.GE2620339@nvidia.com>
References: <20201030114732.GC2620339@nvidia.com>
 <32fa9c9f-5816-7474-b821-ccccd4cb5af0@gmail.com>
 <OFAB5249F6.49569DF7-ON00258611.0045601D-00258611.00467F48@notes.na.collabserv.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OFAB5249F6.49569DF7-ON00258611.0045601D-00258611.00467F48@notes.na.collabserv.com>
X-ClientProxiedBy: BL0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:207:3c::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:207:3c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 16:28:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYXG1-00DPXY-Qv; Fri, 30 Oct 2020 13:28:05 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604075290; bh=JTCRC3CfJezAc++LiBj+NZozC5+MfvMVVB/odU2TAqg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WUh6wZZQRkSbkwqAMOaefEh52LPEqEvD9HJyxURoxIJ8PuVctdKH4SpFeaWN2McNE
         IMX8GVm0ewqLTYRP0RffweImCcVMRAfqdTlZl/yMMlkj8panCxnDSFZhuUBhR4ty7a
         hdxzVCgVwCxvpQ0rjrFviOCkynd8fj6bSz5c8W8dKONiut8Gd/ez3Mes6PE0f0rfde
         8C9ZBgrz994A06PVjdBndYkF82ltn2iozlPeRxXfWKlUymJDaudf6TeoxuQFrlLzbM
         JLQKznIAdDP6xVSjoSfwEweRfyFfwYbs4zX4iHCr/NK/ijesGD1KD0NFBcDc23ikyj
         n5aXKrgzWQTZg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 12:50:01PM +0000, Bernard Metzler wrote:

> I see the hfi and ipath drivers similarly using ibv_cmd_post_send
> to push the wqe's (while not having them in shared mem). Do they
> brake as well?
> Do we have an example of decent eventfd usage where I could learn
> from how to use it?

You'd add a uAPI accepting a eventfd and then call a sequence like:

        init_waitqueue_func_entry(.., my_func);
        init_poll_funcptr(..);

        events = vfs_poll(evfile, ..);

And my_func will be called when the user does write() on the event fd.

drivers/vfio/virqfd.c has the simplest version of this

It could be some core code to do this setup with a new driver callback
'user_doorbell_trigger' or something like that.

However, I see at closer inspection that rxe and siw both want the QPN
to be passed in, so this doesn't look like it would work - an eventfd
per QP is too much overhead.

But calling post_send, even with a 0 length, is really slow.

Jason
