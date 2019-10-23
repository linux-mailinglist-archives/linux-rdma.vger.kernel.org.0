Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB0E24AF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405991AbfJWUjM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:39:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405522AbfJWUjM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 16:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pSqE3hmYI/+sQLgV7gAvhPobWqipjYk4k8HzXm7e+2g=; b=pekN76pMSboMoL32T+2judi6U
        OsQZ8IN28it/uBcbM3PBe9Dqi6m3VX0bxWf3+aN21NJXAS05QjJqQBWYB6seSwSz/gQrLu8lSHMId
        xllJcK2Q0A0tquDgajsrwT6WVZ6uyuRzKdIZHAG6jVUCsOKa0cQaqW1w2rYU+NKIGmSIaHRIC+Xg9
        usNmrTmdx3cf7kjxPl+uEmm4uV7USzZLA/eiy2MuL7uHkOOWfWeddA95GZixMGlsKq2QnlB2RNCIu
        5F6nIDLz3Wi4Q0GL5wGkZUrZCG0Fl/SwrsYJP05BkbY7XftloQaprBLbaCIU3QCcsZiVg0WuhFWfd
        1S+XLkX6A==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNNPT-0000gn-R2; Wed, 23 Oct 2019 20:39:11 +0000
Subject: Re: [PATCH 06/12] infiniband: fix ulp/srpt/ib_srpt.h kernel-doc
 notation
To:     Bart Van Assche <bvanassche@acm.org>, rd.dunlab@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
References: <20191010035239.532908118@gmail.com>
 <20191010035239.950150496@gmail.com>
 <879db40b-1d88-d4ab-082e-b8535cb44cd4@acm.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <41f6a96d-2913-b921-3d2c-219fe55dd22c@infradead.org>
Date:   Wed, 23 Oct 2019 13:39:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <879db40b-1d88-d4ab-082e-b8535cb44cd4@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/23/19 1:30 PM, Bart Van Assche wrote:
> On 2019-10-09 20:52, rd.dunlab@gmail.com wrote:
>> --- linux-next-20191009.orig/drivers/infiniband/ulp/srpt/ib_srpt.h
>> +++ linux-next-20191009/drivers/infiniband/ulp/srpt/ib_srpt.h
>> @@ -387,12 +387,9 @@ struct srpt_port_id {
>>   * @sm_lid:    cached value of the port's sm_lid.
>>   * @lid:       cached value of the port's lid.
>>   * @gid:       cached value of the port's gid.
>> - * @port_acl_lock spinlock for port_acl_list:
>>   * @work:      work structure for refreshing the aforementioned cached values.
>> - * @port_guid_tpg: TPG associated with target port GUID.
>> - * @port_guid_wwn: WWN associated with target port GUID.
>> - * @port_gid_tpg:  TPG associated with target port GID.
>> - * @port_gid_wwn:  WWN associated with target port GID.
>> + * @port_guid_id: target port GUID
>> + * @port_gid_id: target port GID
>>   * @port_attrib:   Port attributes that can be accessed through configfs.
>>   * @refcount:	   Number of objects associated with this port.
>>   * @freed_channels: Completion that will be signaled once @refcount becomes 0.
> 
> This is sufficient to silence the warnings reported by the kernel-doc
> tool but I don't think that the new descriptions make really clear what
> these structure members represent. Do you want to address this or do you
> expect me to post a follow-up patch?

Hi Bart,

Since you know what the descriptions should say, I would appreciate it if you
would post a follow-up patch.

Thanks.
-- 
~Randy

