Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4678151D2C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 16:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBDP0Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 10:26:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:25301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbgBDP0Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 10:26:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 07:26:25 -0800
X-IronPort-AV: E=Sophos;i="5.70,402,1574150400"; 
   d="scan'208";a="235196424"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.112]) ([10.254.205.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2020 07:26:24 -0800
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
To:     Leon Romanovsky <leon@kernel.org>,
        "Goldman, Adam" <adam.goldman@intel.com>
Cc:     linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200204145657.GY414821@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <cbc06c0c-400c-93e9-6ced-11b12927ea03@intel.com>
Date:   Tue, 4 Feb 2020 10:26:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204145657.GY414821@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/4/2020 9:56 AM, Leon Romanovsky wrote:
> On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
>> From: "Goldman, Adam" <adam.goldman@intel.com>
>>
>> PSM2 will not run with recent rdma-core releases. Several tools and
>> libraries like PSM2, require the hfi1 name to be present.
>>
>> Recent rdma-core releases added a new feature to rename kernel devices,
>> but the default configuration will not work with hfi1 fabrics.
>>
>> Related opa-psm2 github issue:
>>    https://github.com/intel/opa-psm2/issues/43
> 
> Why don't you fix opa-psm2 and add required rdma-core version
> checks inside packaging spec files, like we have inside
> redhat/rdma-core.spec?
> 
> Thanks
> 

This is the way PSM has operated from day 1. It has been broken by this 
rename stuff. Clearly not everyone is fan, [1] [2] of the rename.

Seems to me like we should revert back to the original behavior. However 
in lieu of that let HW vendors opt out like what this patch from Adam does.

[1] https://marc.info/?l=linux-rdma&m=158082841016117&w=2
[2] https://marc.info/?l=linux-rdma&m=158082569215149&w=2

-Denny
