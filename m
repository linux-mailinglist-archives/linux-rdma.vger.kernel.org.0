Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5472211AC23
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfLKNeo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 08:34:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:60446 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbfLKNeo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Dec 2019 08:34:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 05:34:43 -0800
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="225527306"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.32]) ([10.254.204.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 11 Dec 2019 05:34:42 -0800
Subject: Re: [PATCH for-next v2 00/11] rdmavt/hfi1 updates for next
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
Message-ID: <3a570d5b-330b-bbc6-9a7a-60a112b1c66b@intel.com>
Date:   Wed, 11 Dec 2019 08:34:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/26/2019 9:12 AM, Dennis Dalessandro wrote:
> Here are some refactoring and code reorg patches for the merge window. Nothing
> too scary, no new features. This lays the ground work for stuff coming in
> future merge cycles.
> 
> There is also one bug fix, from Kaike.
> 
> Changes from v1
> ---------------
> Fix Review-by tags with corrupted email address.
> 
> ---
> 
> Grzegorz Andrejczuk (3):
>        IB/hfi1: Move common receive IRQ code to function
>        IB/hfi1: Decouple IRQ name from type
>        IB/hfi1: Return void in packet receiving functions
> 
> Kaike Wan (1):
>        IB/hfi1: Don't cancel unused work item
> 
> Michael J. Ruhl (1):
>        IB/hfi1: List all receive contexts from debugfs
> 
> Mike Marciniszyn (6):
>        IB/hfi1: Add accessor API routines to access context members
>        IB/hfi1: Move chip specific functions to chip.c
>        IB/hfi1: Add fast and slow handlers for receive context
>        IB/hfi1: IB/hfi1: Add an API to handle special case drop
>        IB/hfi1: Create API for auto activate
>        IB/rdmavt: Correct comments in rdmavt_qp.h header

I guess these didn't catch the train for 5.5 merge window. Do I need to 
resubmit to break this into two series, one for RC and one for next?

I think 1, 9, 10, and 11 could/should probably go for RC.

-Denny

