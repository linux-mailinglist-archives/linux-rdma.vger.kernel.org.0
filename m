Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC79162BC7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgBRRLv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 12:11:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:23360 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgBRRLu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 12:11:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:11:50 -0800
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="228798693"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2020 09:11:48 -0800
Subject: Re: RDMA device renames and node description
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
Date:   Tue, 18 Feb 2020 12:11:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218140444.GB8816@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/2020 9:04 AM, Leon Romanovsky wrote:
> On Fri, Feb 14, 2020 at 01:13:53PM -0500, Dennis Dalessandro wrote:
>> Was there any discussion on the upgrade scenario for existing deployments as
>> far as device-rename changing node descriptions?
>>
>> If someone is running an older version of rdma-core they are going to have a
>> certain set of node descriptions for each node. This could be in logs, or
>> configuration databases, who knows what. Now if they upgrade to a new
>> version of rdma-core their node descriptions all automatically change out
>> from under them by default.
>>
>> Of course the admin could disable the rename prior to upgrade and as Leon
>> pointed out previously the upgrade won't remove the disablement file. The
>> problem is they would have to know to do that ahead of time.
> 
> Dennis,
> 
> It was discussed and the conclusion was that most if not all users are
> using one of two upgrade and strategy.

Do you have a pointer to a thread I can read, I apparently missed it?

> First option is to rely on distro and every distro behaves differently
> in such cases, some of them won't change anything till their last user
> dies :) and others more dynamic with more up-to-date packages already
> adopted our default.

This is the issue I see. The problem is when the distro doesn't know any 
better and pulls in a new rdma-core and breaks things unintentionally. 
Up to date is good, but up to date that brings with it what is 
essentially an ABI breakage is not.

> Second option is to use numerous OFED stacks, which are expected to
> provide full upgrade to all components which will work smoothly.

Yeah I'm sure OFED will handle things for themselves.

> 
> Users who upgrade their system from live upstream repo are expected to
> be proficient enough to be deal with change of defaults.

Yeah this I completely agree with.

-Denny
