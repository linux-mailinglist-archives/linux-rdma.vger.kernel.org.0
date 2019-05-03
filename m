Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C484212AC9
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfECJhk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 05:37:40 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:8728 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECJhk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 05:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556876259; x=1588412259;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j7Y2ebzLBrRaPegeIneetgsL2/NGDUimTMsy5pcOGuQ=;
  b=oPcRmSMsAHZ8ZHSYDS3DatzjzEJBV8xdLSC/aN0P63NvZTghqqMMZo0L
   Cbe6nwdbnO1XfdEwRLcU2rvS/STITB3315ym61RmGZGZmPtD9tapGFtE4
   JnfBmZ3rO+3frOFiUgUlEhsP2k0PoNuYp+/CdYuqm0rRD3oikkEwopUfo
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,425,1549929600"; 
   d="scan'208";a="797638031"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 May 2019 09:37:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x439bWUC006967
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 May 2019 09:37:33 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 May 2019 09:37:32 +0000
Received: from [10.95.88.5] (10.43.161.192) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 3 May
 2019 09:37:18 +0000
Subject: Re: [PATCH for-next v6 08/12] RDMA/efa: Implement functions that
 submit and complete admin commands
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
 <20190502135505.GA21208@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
Date:   Fri, 3 May 2019 12:37:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502135505.GA21208@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13P01UWA001.ant.amazon.com (10.43.160.213) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02-May-19 16:55, Jason Gunthorpe wrote:
> On Wed, May 01, 2019 at 01:48:20PM +0300, Gal Pressman wrote:
> 
>> +static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
>> +						     struct efa_admin_aq_entry *cmd,
>> +						     size_t cmd_size_in_bytes,
>> +						     struct efa_admin_acq_entry *comp,
>> +						     size_t comp_size_in_bytes)
>> +{
>> +	struct efa_comp_ctx *comp_ctx;
>> +
>> +	spin_lock(&aq->sq.lock);
>> +	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
>> +		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
>> +		spin_unlock(&aq->sq.lock);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	comp_ctx = __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes, comp,
>> +					      comp_size_in_bytes);
>> +	spin_unlock(&aq->sq.lock);
>> +	if (IS_ERR(comp_ctx))
>> +		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>> +
>> +	return comp_ctx;
>> +}
> 
> [..]
> 
>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
>> +{
>> +	struct efa_com_admin_queue *aq = &edev->aq;
>> +
>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> 
> This scheme looks use after free racey to me..

The running bit stops new admin commands from being submitted, clearly the exact
moment in which the bit is cleared is "racy" to submission of admin commands but
that is taken care of.

The submission of an admin command is atomic as it is guarded by an admin queue
lock.
The same lock is acquired by this flow as well when flushing the admin queue.
After all admin commands have been aborted and we know for sure that no new
admin commands will be submitted (the bit test is also done inside the lock) we
wait for all commands completions and only then, when all consumers are done, we
safely disable the admin queue.
