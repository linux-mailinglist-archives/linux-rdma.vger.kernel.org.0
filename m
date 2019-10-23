Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD3E196D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405145AbfJWLyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 07:54:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:13649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfJWLyv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 07:54:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:54:50 -0700
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="210017354"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.232]) ([10.254.201.232])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 23 Oct 2019 04:54:48 -0700
Subject: Re: [PATCH 00/12] infiniband kernel-doc fixes & driver-api/ chapter
To:     Jason Gunthorpe <jgg@ziepe.ca>, rd.dunlab@gmail.com,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20191010035239.532908118@gmail.com>
 <20191022184109.GA2155@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <52276493-6c27-0bdd-2b3a-6475056dd4f1@intel.com>
Date:   Wed, 23 Oct 2019 07:54:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022184109.GA2155@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/22/2019 2:41 PM, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2019 at 08:52:39PM -0700, rd.dunlab@gmail.com wrote:
>>
>> This patch series cleans up lots of kernel-doc in drivers/infiniband/
>> and then adds an infiniband.rst file.
>>
>> It also changes a few instances of non-exported functions from kernel-doc
>> notation back to non-kernel-doc comments.
>>
>> There are still a few kernel-doc and Sphinx warnings that I don't know how
>> to resolve:
>>
>>    ../drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
>>    ../drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
> 
> Maybe Max can help?
> 
>>    ../drivers/infiniband/core/verbs.c:2510: WARNING: Unexpected indentation.
>>    ../drivers/infiniband/core/verbs.c:2512: WARNING: Block quote ends without a blank line; unexpected unindent.
>>    ../drivers/infiniband/core/verbs.c:2544: WARNING: Unexpected indentation.
> 
> I don't know what to make of these either.
> 
> Anyhow, it is an overall improvement, so I applied everything but
> 
> [05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h kernel-doc notation

Safe to assume the kbuild robot failure [1] is a result of this?

[1] https://marc.info/?l=linux-rdma&m=157177785916141&w=2

-Denny

