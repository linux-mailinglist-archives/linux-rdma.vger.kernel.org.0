Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2216878E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 20:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgBUTkz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 14:40:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:43155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgBUTkz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 14:40:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 11:40:55 -0800
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="229948170"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2020 11:40:53 -0800
Subject: Re: [PATCH for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
To:     Erez Shitrit <erezsh@dev.mellanox.co.il>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marcinisyzn@intel.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210131850.87776.40842.stgit@awfm-01.aw.intel.com>
 <CAAk-MO-NZbL8WjUB+eupK_0uYAJXEyvKjEVX8Bo5DzkExNnweg@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <4fcc4401-8255-87a3-6b64-056579855fcb@intel.com>
Date:   Fri, 21 Feb 2020 14:40:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAk-MO-NZbL8WjUB+eupK_0uYAJXEyvKjEVX8Bo5DzkExNnweg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 6:01 AM, Erez Shitrit wrote:
>> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> index e5f438a..5c1cf68 100644
>> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> @@ -1862,7 +1862,10 @@ static int ipoib_parent_init(struct net_device *ndev)
>>                          priv->port);
>>                  return result;
>>          }
>> -       priv->max_ib_mtu = ib_mtu_enum_to_int(attr.max_mtu);
>> +       if (rdma_core_cap_opa_port(priv->ca, priv->port))
> 
> Why not to use something like you did in rdma_mtu_enum_to_int, in
> order to hide all the "_opa_" stuff from IPoIB ?

Sounds reasonable, we can do that in the v2.

-Denny
