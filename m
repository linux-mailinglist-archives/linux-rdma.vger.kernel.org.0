Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC1DF21D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJUP4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 11:56:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:13436 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJUP4L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 11:56:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 08:56:10 -0700
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="191149938"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.232]) ([10.254.201.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 21 Oct 2019 08:56:08 -0700
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
Date:   Mon, 21 Oct 2019 11:55:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/15/2019 2:12 PM, Jason Gunthorpe wrote:
> This is still being tested, but I figured to send it to start getting help
> from the xen, amd and hfi drivers which I cannot test here.

Sorry for the delay, I never seen this. Was not on Cc list and didn't 
register to me it impacted hfi. I'll take a look and run it through some 
hfi1 tests.

-Denny
