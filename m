Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7151CDFCD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgEKQAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:00:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:37205 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgEKQAN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:00:13 -0400
IronPort-SDR: T4AkVz9Y8TkDpNAlxkXy5hOZg3C63dtbuHZUwCsz7QgJtzEKfyJuzSghKj2ln3B3irW5hljx96
 hprdYsVBRCvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:00:13 -0700
IronPort-SDR: EcAd1EIzjM1eEBxLChA9vLkDpeowyXTeVxADluTyoxHmGWxYT6mdQeVlTXE3sEJdfOwJX4tKrn
 R5kVLL8Ie9mw==
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="408963456"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.232]) ([10.254.204.232])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:00:11 -0700
Subject: Re: [PATCH v2 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com,
        Mike Marciniszyn <mike.marcinisyzn@intel.com>,
        linux-rdma@vger.kernel.org,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
 <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
 <20200324054536.GR650439@unreal>
 <a8a8176c-393c-5fbf-c2e1-14d9b20b71cd@intel.com>
Message-ID: <bba6ec55-ce13-d520-153b-72e3556378b8@intel.com>
Date:   Mon, 11 May 2020 12:00:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a8a8176c-393c-5fbf-c2e1-14d9b20b71cd@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/24/2020 9:46 AM, Dennis Dalessandro wrote:
> On 3/24/2020 1:45 AM, Leon Romanovsky wrote:
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index babfdb0..da8d0d6 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -462,6 +462,11 @@ enum ib_mtu {
>>>       IB_MTU_4096 = 5
>>>   };
>>>
>>> +enum opa_mtu {
>>> +    OPA_MTU_8192 = 6,
>>> +    OPA_MTU_10240 = 7
>>> +};
>>> +
>>>   static inline int ib_mtu_enum_to_int(enum ib_mtu mtu)
>>>   {
>>>       switch (mtu) {
>>> @@ -488,6 +493,28 @@ static inline enum ib_mtu ib_mtu_int_to_enum(int 
>>> mtu)
>>>           return IB_MTU_256;
>>>   }
>>>
>>> +static inline int opa_mtu_enum_to_int(enum opa_mtu mtu)
>>> +{
>>> +    switch (mtu) {
>>> +    case OPA_MTU_8192:
>>> +        return 8192;
>>> +    case OPA_MTU_10240:
>>> +        return 10240;
>>> +    default:
>>> +        return(ib_mtu_enum_to_int((enum ib_mtu)mtu));
>>> +    }
>>> +}
>>> +
>>> +static inline enum opa_mtu opa_mtu_int_to_enum(int mtu)
>>> +{
>>> +    if (mtu >= 10240)
>>> +        return OPA_MTU_10240;
>>> +    else if (mtu >= 8192)
>>> +        return OPA_MTU_8192;
>>> +    else
>>> +        return ((enum opa_mtu)ib_mtu_int_to_enum(mtu));
>>> +}
>>
>> Is it possible to include opa_port_info.h in the ib_verbs.h and leave all
>> those functions there?
> 
> We can take a look at doing that.

Seems like it will bring in a number of changes that doesn't really buy 
us anything. We are only adding two inline functions and an enum here. 
Not like it's a ton of stuff.

-Denny

