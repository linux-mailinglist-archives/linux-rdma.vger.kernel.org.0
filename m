Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D116878D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgBUTkp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 14:40:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:47935 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgBUTkp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 14:40:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 11:40:44 -0800
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="229948147"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2020 11:40:43 -0800
Subject: Re: [PATCH for-next 13/16] IB/{hfi1, ipoib, rdma}: Broadcast ping
 sent packets which exceeded mtu size
To:     Erez Shitrit <erezsh@dev.mellanox.co.il>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
 <CAAk-MO91iV9GDZChWCKjMAmv553EDGfSdr9B8aFw1f4yncx-Wg@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <8f336a93-5910-3954-5931-08aa590031de@intel.com>
Date:   Fri, 21 Feb 2020 14:40:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAk-MO91iV9GDZChWCKjMAmv553EDGfSdr9B8aFw1f4yncx-Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 8:41 AM, Erez Shitrit wrote:
> On Mon, Feb 10, 2020 at 3:19 PM Dennis Dalessandro
> <dennis.dalessandro@intel.com> wrote:
>>
>> From: Gary Leshner <Gary.S.Leshner@intel.com>
>>
>> When in connected mode ipoib sent broadcast pings which exceeded the mtu
>> size for broadcast addresses.
> 
> But this broadcast done via the UD QP and not via the connected mode,
> please explain

It still lands in the ipoib_send() function though which does the length 
check for non-AIP. With AIP we still need to do a similar check.

>> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
>> @@ -1906,6 +1906,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
>>   {
>>          struct ipoib_dev_priv *priv = ipoib_priv(ndev);
>>          int rc;
>> +       struct rdma_netdev *rn = netdev_priv(ndev);
>>
>>          if (priv->parent) {
>>                  ipoib_child_init(ndev);
>> @@ -1918,6 +1919,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
>>          /* MTU will be reset when mcast join happens */
>>          ndev->mtu = IPOIB_UD_MTU(priv->max_ib_mtu);
>>          priv->mcast_mtu = priv->admin_mtu = ndev->mtu;
>> +       rn->mtu = priv->mcast_mtu;
> 
> If this is something specific for your lower driver (opa_vnic etc.)
> you don't need to do that here, you can use the rn->clnt_priv member
> in order to get the mcast_mtu

That's probably doable, sure. However this seems like something we don't 
want to hide away as a private member. The Mcast MTU is a pretty central 
concept and some other lower driver may conceivably make sue of it. Is 
there a reason we don't want to add to the rn?

The other complication is struct ipoib_dev_priv is not available to 
hfi1, it is a ULP concept and hfi1 should probably not be made aware?

-Denny

