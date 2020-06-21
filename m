Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4067E2029A3
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 10:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgFUIaa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgFUIa3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Jun 2020 04:30:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7ACC061794
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 01:30:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so14802493ejc.3
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7fJ+xfBfhE+rkUN1xnzmLzZij3gT7nZAWGcQfl3tTA=;
        b=M9vjdmsul0D38V+sJ25KDKzkdVX5xwfjpEq+RtvVhTb3EoEZ5g939l1Q1F7MdeIGNx
         ONs9Q9kjt0XHDphvu5trYPLGmgiaQBtxE3izthv9/newG8MNRo47ksSMez0lkZgetqaf
         agdX2bH6jmvDRWnaHHJjKRivX//FZHrHNZzi8c00mL+B7pnVNB3Odk8OuCzT6DGmwlw3
         YZ+iI7C8sijjP8Xpdf9snBYlJ7XOGU1AUAxl2P2W/H4pnPSidyyBjvm4k+CcGG8UL/0j
         gUyqEzmmfwHlE/aq8maO+iNV8a3mzJhmtR35Z9kQCyBol4eFiJaRdsJrMQ2EiDBM344A
         43TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7fJ+xfBfhE+rkUN1xnzmLzZij3gT7nZAWGcQfl3tTA=;
        b=biAuXjFUKDEWH6SJAd3QYmrAegFiMgvMA85HQVMncnFEMqqbqLFdOIuOGhNNLviWl7
         IvA2VfiSFF36WGmlY+VWyh3YwQcldrWS6pmFtET+zXyJeNQf8H6oAIrQbdotT1Xo6rkP
         V1R/ZFVAptSQjTAIR8fgEqKKQSUXmrVlNdEcSpmzK7ZoWJgWcoigZW57NQdfpNuWj9XZ
         FPdNrSVJM/y6c7hIPg454Wn4mDcw6N++8Pv4qeZQFGqK0nRahIoRsnSf+lQxeQ3mobCk
         MADmtXjuugVv5niAQop2N621j4AglSAHMpiT3TuXEG6F1BPmJpCV6+3BTRVfYSxe4VYO
         +67A==
X-Gm-Message-State: AOAM533hnPgUYYTsrxnYEk+0q/Bjm0VX+xLHZAobafvbCY1pShk0MVAU
        0P1/tetv2v7GcXZYvCbRS6aM3g==
X-Google-Smtp-Source: ABdhPJyJygjOGgqWUKXNZExrbRySQiiKMU62UzevShsl5b/i5sRWKtDd6SPWHglXgU0wxQXiwYYpIg==
X-Received: by 2002:a17:907:35c2:: with SMTP id ap2mr10373559ejc.530.1592728228176;
        Sun, 21 Jun 2020 01:30:28 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.189])
        by smtp.googlemail.com with ESMTPSA id hb8sm3175438ejb.8.2020.06.21.01.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 01:30:27 -0700 (PDT)
Subject: Re: [PATCH rdma-core 07/13] verbs: Introduce ibv_import/unimport_pd()
 verbs
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-8-git-send-email-yishaih@mellanox.com>
 <20200619124852.GV65026@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <f2df3448-8227-3f2b-477c-49cfe54d877f@dev.mellanox.co.il>
Date:   Sun, 21 Jun 2020 11:30:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619124852.GV65026@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/19/2020 3:48 PM, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 10:45:50AM +0300, Yishai Hadas wrote:
>> Introduce ibv_import/unimport_pd() verbs, this enables an application
>> who previously imported a device to import a PD from that context and
>> use this shared object for its needs.
>>
>> A detailed man page as part of this patch describes the expected usage
>> and flow.
>>
>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>>   debian/libibverbs1.symbols        |  2 ++
>>   libibverbs/driver.h               |  3 +++
>>   libibverbs/dummy_ops.c            | 15 +++++++++++
>>   libibverbs/libibverbs.map.in      |  2 ++
>>   libibverbs/man/CMakeLists.txt     |  2 ++
>>   libibverbs/man/ibv_import_pd.3.md | 57 +++++++++++++++++++++++++++++++++++++++
>>   libibverbs/verbs.c                | 14 ++++++++++
>>   libibverbs/verbs.h                | 11 ++++++++
>>   8 files changed, 106 insertions(+)
>>   create mode 100644 libibverbs/man/ibv_import_pd.3.md
>>
>> diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
>> index e636c1d..ee32bf4 100644
>> +++ b/debian/libibverbs1.symbols
>> @@ -68,6 +68,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
>>    ibv_get_pkey_index@IBVERBS_1.5 20
>>    ibv_get_sysfs_path@IBVERBS_1.0 1.1.6
>>    ibv_import_device@IBVERBS_1.10 31
>> + ibv_import_pd@IBVERBS_1.10 31
>>    ibv_init_ah_from_wc@IBVERBS_1.1 1.1.6
>>    ibv_modify_qp@IBVERBS_1.0 1.1.6
>>    ibv_modify_qp@IBVERBS_1.1 1.1.6
>> @@ -102,6 +103,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
>>    ibv_resize_cq@IBVERBS_1.0 1.1.6
>>    ibv_resize_cq@IBVERBS_1.1 1.1.6
>>    ibv_resolve_eth_l2_from_gid@IBVERBS_1.1 1.2.0
>> + ibv_unimport_pd@IBVERBS_1.10 31
>>    ibv_wc_status_str@IBVERBS_1.1 1.1.6
>>    mbps_to_ibv_rate@IBVERBS_1.1 1.1.8
>>    mult_to_ibv_rate@IBVERBS_1.0 1.1.6
>> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
>> index 1883df3..fbf63f3 100644
>> +++ b/libibverbs/driver.h
>> @@ -311,6 +311,8 @@ struct verbs_context_ops {
>>   	void (*free_context)(struct ibv_context *context);
>>   	int (*free_dm)(struct ibv_dm *dm);
>>   	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
>> +	struct ibv_pd *(*import_pd)(struct ibv_context *context,
>> +				    uint32_t pd_handle);
>>   	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
>>   	int (*modify_flow_action_esp)(struct ibv_flow_action *action,
>>   				      struct ibv_flow_action_esp_attr *attr);
>> @@ -361,6 +363,7 @@ struct verbs_context_ops {
>>   	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
>>   			void *addr, size_t length, int access);
>>   	int (*resize_cq)(struct ibv_cq *cq, int cqe);
>> +	void (*unimport_pd)(struct ibv_pd *pd);
>>   };
>>   
>>   static inline struct verbs_device *
>> diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
>> index 32fec71..9d6d2af 100644
>> +++ b/libibverbs/dummy_ops.c
>> @@ -287,6 +287,13 @@ static int get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
>>   	return EOPNOTSUPP;
>>   }
>>   
>> +static  struct ibv_pd *import_pd(struct ibv_context *context,
>> +				 uint32_t pd_handle)
> 
> Extra space after static
> 

OK

>> +
>> +# DESCRIPTION
>> +
>> +**ibv_import_pd()** returns a protection domain (PD) that is associated with the given
>> +*pd_handle* in the given *context*.
> 
> Explain how to get pd_handle in the first place, same comment for all
> of these man pages
> 

Sure, will do.

Yishai
