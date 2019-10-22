Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF17E0382
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbfJVL4S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 07:56:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:15369 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbfJVL4S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 07:56:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 04:56:17 -0700
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="191437251"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.232]) ([10.254.201.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 22 Oct 2019 04:56:15 -0700
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
 <20191021165828.GA6285@mellanox.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <35d803f3-a24a-8a5f-745b-52c2f9876b7c@intel.com>
Date:   Tue, 22 Oct 2019 07:56:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021165828.GA6285@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/2019 12:58 PM, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 11:55:51AM -0400, Dennis Dalessandro wrote:
>> On 10/15/2019 2:12 PM, Jason Gunthorpe wrote:
>>> This is still being tested, but I figured to send it to start getting help
>>> from the xen, amd and hfi drivers which I cannot test here.
>>
>> Sorry for the delay, I never seen this. Was not on Cc list and didn't
>> register to me it impacted hfi. I'll take a look and run it through some
>> hfi1 tests.
> 
> Hm, you were cc'd on the hfi1 patch of the series:
> 
> https://patchwork.kernel.org/patch/11191395/
> 
> So you saw that, right?

I do now.

> But it seems that git send-email didn't pull all the cc's together?

I don't know. I thought it did, at one time I recall trying to get it 
*not* to do that, when preparing some internal reviews. Haven't used it 
for a long time though, I've been using stgit.

At any rate can you give me a SHA or branch this applies on top of? I 
have pulled rdma/hmm, rdma/wip/jgg, linus/master but seem to have conflicts.

-Denny



