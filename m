Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BFFE0CCA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfJVTvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:51:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfJVTvt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tglp08FPG85hsscttcMSUeJKF5mvx+KUX56tA2YsZbU=; b=qOQv5wI5bFAq0uQ21RGjuGRiX
        0Nw7Ug/enTjOE4E4ppEHCFzpPDp7ZF0PUmFvwBWdzk1DpralPjMK4Z7xeYKfZzJ2cm4ng2U7EmtnU
        XbMomBrph7g/QV0wUi49VHBSCP+yphF7LEEWDZWpeDSgE+qvoRUIPQXj/3off/9FccigHFydrmpUo
        lqOoZhSLETCoDoZ/ewAki2L/LZFuvWkHM70SpQhR1i51K8S/QKHg5znjK+wfOI70l3bypSJsiCcEW
        HLqQalifQnYHm/+Q+WZC4Y+Yx5v4TS6eyx18RIqpWN28gAAvp6/I3z3EmZT7WQDzoZdUT8ZhUHdqN
        uifZuJILg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iN0C4-0002Iv-Vm; Tue, 22 Oct 2019 19:51:49 +0000
Subject: Re: [PATCH 05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h
 kernel-doc notation
To:     Jason Gunthorpe <jgg@ziepe.ca>, rd.dunlab@gmail.com
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-doc@vger.kernel.org
References: <20191010035239.532908118@gmail.com>
 <20191010035239.890311169@gmail.com> <20191022175215.GA26528@ziepe.ca>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e6be1ddd-c32f-4f8a-4528-7393d5997755@infradead.org>
Date:   Tue, 22 Oct 2019 12:51:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022175215.GA26528@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/22/19 10:52 AM, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2019 at 08:52:44PM -0700, rd.dunlab@gmail.com wrote:
>> Make reserved struct fields "private:" so that they don't need to
>> be added to the kernel-doc notation. This removes 24 warnings.
> 
>> +++ linux-next-20191009/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
>> @@ -129,21 +129,31 @@ struct opa_vesw_info {
>>  	__be16  fabric_id;
>>  	__be16  vesw_id;
>>  
>> +	/* private: */
>>  	u8      rsvd0[6];
>> +	/* public: */
>>  	__be16  def_port_mask;
> 
> This seems overly ugly, is there some other way to handle these
> reserved fields? Maybe wire protocol structures shouldn't be kdoc?

I don't know of any other way to handle them with kernel-doc.
Sure, changing the /** to just /* would be one way to hide the
warnings.  Either this patch or not having them be kernel-doc
is needed just to "fix" 24 warnings.

-- 
~Randy

