Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCAFE31EB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439617AbfJXMLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 08:11:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:16457 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439599AbfJXMLp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 08:11:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 05:11:45 -0700
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="210360228"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.232]) ([10.254.201.232])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 24 Oct 2019 05:11:44 -0700
Subject: Re: [PATCH for-next] selftests: rdma: Add rdma tests
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20191023173954.29291-1-kamalheib1@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <678dceaf-2b00-f6a7-c67a-f1e43095c22e@intel.com>
Date:   Thu, 24 Oct 2019 08:11:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023173954.29291-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/23/2019 1:39 PM, Kamal Heib wrote:
> +
> +rdma dev show 2>/dev/null >/dev/null
> +check_and_skip $? "Can not run the test without rdma tool"
> +

I like the idea of some self tests in theory, actually really like the 
idea. However I do not think it is a good idea to be tied to a user tool 
that may or may not be available.

Also I think we need to ask ourselves, what are we actually testing. The 
kernel and it's interfaces, or the HW? Not so sure the latter is what we 
want.

-Denny


