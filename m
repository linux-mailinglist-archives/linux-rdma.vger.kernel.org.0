Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEF170055
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgBZNnB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 08:43:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:18702 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNnB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 08:43:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 05:43:00 -0800
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="231401328"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.200]) ([10.254.202.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Feb 2020 05:42:59 -0800
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
To:     Leon Romanovsky <leon@kernel.org>, Jens Domke <jens.domke@riken.jp>
Cc:     Haim Boozaglo <haimbo@mellanox.com>, linux-rdma@vger.kernel.org
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200225074815.GB5347@unreal>
 <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
 <20200225091815.GE5347@unreal>
 <52f4364b-30c5-5c62-36bb-78341ca8fe6e@riken.jp>
 <20200225194303.GA12414@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <dbb87a79-2edb-b19b-7408-267db7587a5c@intel.com>
Date:   Wed, 26 Feb 2020 08:42:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225194303.GA12414@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/25/2020 2:43 PM, Leon Romanovsky wrote:
>> I (and highly likely many other admins out there who don't follow this
>> list) am in full support of Haim's request for sorted output.
> 
> I don't see any API or utils in the rdma-core which promised to provide
> sorted output.

That is true, but when sys admins count on things in a certain way and 
the rug gets pulled out from under them that's a headache at best.

>>
>> Not everything can/will be pinned down in a manpage, but if you insist
>> then sure someone can submit a amendment to the ibstat documentation
>> which demands alphanumeric sorting for the NICs/ports.
> 
> The manual is not enough, what about other tools? Should we update them
> too? Or do we need to make ibstat special while rest of the tools keep
> the list unsorted?
> 
> Maybe I'm part of the problem, but any solution will require unified
> approach for whole rdma-core, so users like you will get stable and
> consistent result from any rdma-core API/tool.

So am I understanding this right, the crux of the problem is the code 
switched from using scandir() via libibumad to readdir(). The later of 
which does not keep the same sorted order?

Maybe let's look at why the change was done in the first place rather 
than arguing over which way it should be. Is there a good reason to go 
with readdir() approach if so then maybe that out weights the 
inconvenience of not getting a sorted list. Or maybe it doesn't.

-Denny
