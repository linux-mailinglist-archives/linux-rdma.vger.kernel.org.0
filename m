Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5625154A8C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBFRwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 12:52:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:31550 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFRwB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Feb 2020 12:52:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:52:01 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="236049901"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.112]) ([10.254.205.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2020 09:52:00 -0800
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200205191227.GE28298@ziepe.ca>
 <daa60df0-04e1-d33c-fdc9-5a3fea2688cb@intel.com>
 <20200205205402.GC25297@ziepe.ca>
 <0f9fd27d-4bb8-b51d-1fdc-20a5b0d5d9e2@intel.com>
 <20200206135226.GE25297@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <0706151d-836d-c1e3-6cfb-d10d6eb7d2f1@intel.com>
Date:   Thu, 6 Feb 2020 12:51:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206135226.GE25297@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/6/2020 8:52 AM, Jason Gunthorpe wrote:
> On Wed, Feb 05, 2020 at 04:59:11PM -0500, Dennis Dalessandro wrote:
>>> I would actively block an attempt to try and do an end-run around
>>> upstream like this. rdma-core is supposed to be the defacto
>>> configuration, not be modified randomly by distros as before.
>>
>> No but users should be free to name their devices how they want should they
>> not?
> 
> Isn't that exactly why PSM is broken?
> 
> These days I can do
> 
> $ rdma link add hfi1_0 type siw netdev eth0
> 
> and PSM will become very confused.
> 
> This is why keying off the device name was *never* OK.
> 
>>> Why isn't psm keying off it's own chardev anyhow? There should be back
>>> links to the RDMA device in sysfs from there.
>>
>> No arguments here. No sense in going down this road though at this point in
>> the game.
> 
> I'm not sure what these means? Are you saying you won't be fixing PSM? Why?
> 

It's not worth going through the same to have a cdev or not argument 
over again.

-Denny
