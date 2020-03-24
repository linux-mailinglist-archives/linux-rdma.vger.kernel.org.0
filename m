Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A091911C8
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgCXNq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 09:46:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:9199 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbgCXNq0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 09:46:26 -0400
IronPort-SDR: BSS69do+hlG0xr19GqKJh57LF3bHaxcFm0twRDYsTui1kHnZkDOqkTsEUuk6Bs2BdaEr2T/ZNg
 zNgCou382yMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 06:46:26 -0700
IronPort-SDR: tS6QY+jKBUuFi/+hBntpOGqUGNmEcDYgQh7BAmIyu6VGd9ylGst9YBhqKX86/uh+lGKHuFRHkL
 AcEp2NMv8Llg==
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="238237056"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.203.77]) ([10.254.203.77])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 06:46:24 -0700
Subject: Re: [PATCH v2 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com,
        Mike Marciniszyn <mike.marcinisyzn@intel.com>,
        linux-rdma@vger.kernel.org,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
 <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
 <20200324054536.GR650439@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a8a8176c-393c-5fbf-c2e1-14d9b20b71cd@intel.com>
Date:   Tue, 24 Mar 2020 09:46:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324054536.GR650439@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/24/2020 1:45 AM, Leon Romanovsky wrote:
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index babfdb0..da8d0d6 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -462,6 +462,11 @@ enum ib_mtu {
>>   	IB_MTU_4096 = 5
>>   };
>>
>> +enum opa_mtu {
>> +	OPA_MTU_8192 = 6,
>> +	OPA_MTU_10240 = 7
>> +};
>> +
>>   static inline int ib_mtu_enum_to_int(enum ib_mtu mtu)
>>   {
>>   	switch (mtu) {
>> @@ -488,6 +493,28 @@ static inline enum ib_mtu ib_mtu_int_to_enum(int mtu)
>>   		return IB_MTU_256;
>>   }
>>
>> +static inline int opa_mtu_enum_to_int(enum opa_mtu mtu)
>> +{
>> +	switch (mtu) {
>> +	case OPA_MTU_8192:
>> +		return 8192;
>> +	case OPA_MTU_10240:
>> +		return 10240;
>> +	default:
>> +		return(ib_mtu_enum_to_int((enum ib_mtu)mtu));
>> +	}
>> +}
>> +
>> +static inline enum opa_mtu opa_mtu_int_to_enum(int mtu)
>> +{
>> +	if (mtu >= 10240)
>> +		return OPA_MTU_10240;
>> +	else if (mtu >= 8192)
>> +		return OPA_MTU_8192;
>> +	else
>> +		return ((enum opa_mtu)ib_mtu_int_to_enum(mtu));
>> +}
> 
> Is it possible to include opa_port_info.h in the ib_verbs.h and leave all
> those functions there?

We can take a look at doing that.

-Denny
