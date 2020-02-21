Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1716878C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBUTkc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 14:40:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:16657 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgBUTkc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 14:40:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 11:40:31 -0800
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="229948126"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2020 11:40:30 -0800
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
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <2c91a053-add3-a7f9-2da1-f56f4c70381d@intel.com>
Date:   Fri, 21 Feb 2020 14:40:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219004249.GA24178@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/2020 7:42 PM, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 08:19:44AM -0500, Dennis Dalessandro wrote:
>> From: Gary Leshner <Gary.S.Leshner@intel.com>
>>
>> When in connected mode ipoib sent broadcast pings which exceeded the mtu
>> size for broadcast addresses.
>>
>> Add an mtu attribute to the rdma_netdev structure which ipoib sets to its
>> mcast mtu size.
>>
>> The RDMA netdev uses this value to determine if the skb length is too long
>> for the mtu specified and if it is, drops the packet and logs an error
>> about the errant packet.
> 
> I'm confused by this comment, connected mode is not able to use
> rdma_netdev, for various technical reason, I thought?
> 
> Is this somehow running a rdma_netdev concurrently with connected
> mode? How?

No, not concurrently. When ipoib is in connected mode, a broadcast 
request, something like:

ping -s 2017 -i 0.001 -c 10 -M do -I ib0 -b 192.168.0.255

will be sent down from user space to ipoib. At an mcast_mtu of 2048, the 
max payload size is 2016 (2048 - 28 - 4). If AIP is not being used then 
the datagram send function (ipoib_send()) does a check and drops the packet.

However when AIP is enabled ipoib_send is of course not used and we land 
in rn->send function. Which needs to do the same check.

Alternatively, the mcast_mtu check could be added to ipoib so that this 
checking is performed before rn->send() is called. In that case, this 
patch will not be needed and the new rdma_netdev (or clnt_priv) field 
that shadows mcast_mtu would also not be needed.

Also for the datagram mode case, the ping command will correctly check 
the payload size and drop the request in the user
space so that ipoib will not receive the broadcast request at all:

   ping -s 2017 -i 0.001 -c 1 -M do -I ib0 -b 192.168.0.255
   WARNING: pinging broadcast address
   PING 192.168.0.255 (192.168.0.255) from 192.168.0.1 ib0: 2017(2045) 
bytes of data.
   ping: local error: Message too long, mtu=2044

-Denny
