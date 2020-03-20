Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADCF18CF7D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 14:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCTNxb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 09:53:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:7268 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTNxb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 09:53:31 -0400
IronPort-SDR: 7sqVtrrBX3agBiD7K0v2j9oMUJPtnAfcTBt6vrVKkDbFLu0Xx4ChYE/No4Z4Y2XUEZ7MdccXFD
 VMxo0W/efeMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 06:53:30 -0700
IronPort-SDR: ppjv/nDQKVNeqoB5wdkIbuWd5NuwdUewZeVxapcTbftpphlug9EqDwjc9x/wKfMyLPKQ1sSWGe
 ljoI7nlTQ7sg==
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="234512596"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.204]) ([10.254.204.204])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 06:53:28 -0700
Subject: Re: [PATCH for-next 13/16] IB/{hfi1, ipoib, rdma}: Broadcast ping
 sent packets which exceeded mtu size
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
 <20200219004249.GA24178@ziepe.ca>
 <2c91a053-add3-a7f9-2da1-f56f4c70381d@intel.com>
 <20200221233249.GM31668@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <277fe13b-63f7-e633-7f72-9c3e9932863c@intel.com>
Date:   Fri, 20 Mar 2020 09:53:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200221233249.GM31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/21/2020 6:32 PM, Jason Gunthorpe wrote:
> On Fri, Feb 21, 2020 at 02:40:28PM -0500, Dennis Dalessandro wrote:
>> On 2/18/2020 7:42 PM, Jason Gunthorpe wrote:
>>> On Mon, Feb 10, 2020 at 08:19:44AM -0500, Dennis Dalessandro wrote:
>>>> From: Gary Leshner <Gary.S.Leshner@intel.com>
>>>>
>>>> When in connected mode ipoib sent broadcast pings which exceeded the mtu
>>>> size for broadcast addresses.
>>>>
>>>> Add an mtu attribute to the rdma_netdev structure which ipoib sets to its
>>>> mcast mtu size.
>>>>
>>>> The RDMA netdev uses this value to determine if the skb length is too long
>>>> for the mtu specified and if it is, drops the packet and logs an error
>>>> about the errant packet.
>>>
>>> I'm confused by this comment, connected mode is not able to use
>>> rdma_netdev, for various technical reason, I thought?
>>>
>>> Is this somehow running a rdma_netdev concurrently with connected
>>> mode? How?
>>
>> No, not concurrently. When ipoib is in connected mode, a broadcast request,
>> something like:
>>
>> ping -s 2017 -i 0.001 -c 10 -M do -I ib0 -b 192.168.0.255
>>
>> will be sent down from user space to ipoib. At an mcast_mtu of 2048, the max
>> payload size is 2016 (2048 - 28 - 4). If AIP is not being used then the
>> datagram send function (ipoib_send()) does a check and drops the packet.
>>
>> However when AIP is enabled ipoib_send is of course not used and we land in
>> rn->send function. Which needs to do the same check.
> 
> You just contradicted yourself: the first sentence was 'not
> concurrently' and here you say we have connected mode turned on and
> yet a packet is delivered to AIP, so what do you mean?

AIP provides a rdma_netdev (rn) that overloads the rn inside ipoib. When 
the broadcast skb is passed down from the user space, even in connected 
mode, the skb will be forwarded to the rn to send out.

> What I mean is if you can do connected mode you don't have a
> rdma_netdev and you can't do AIP.

The rdma_netdev is always present, regardless of the ipoib mode.

> How are things in connected mode and a rdma_netdev is available?

So we don't only overload the rn for datagram, we do it for connected as 
well.

The rdma_netdev is set up when ipoib first finds the port, not when the 
mode is switched through sysfs. Therefore, it has to be there always, 
even in connected mode.

In hfi1_ipoib_setup_rn() (the setup function for rdma_netdev), we set:
     rn->send = hfi1_ipoib_send

We also keeps the default netdev_ops and overload it with our netdev_ops 
to set up /tear down resources during netdev init/uninit/open/close:

     Priv->netdev_ops = netdev->netdev_ops;
     Netdev->netdev_ops = &hfi1_ipoib_netdev_ops;

-Denny

