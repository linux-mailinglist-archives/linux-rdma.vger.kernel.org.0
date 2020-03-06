Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC717C125
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2020 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCFPDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Mar 2020 10:03:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:47985 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFPDr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Mar 2020 10:03:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 07:03:47 -0800
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; 
   d="scan'208";a="287991101"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.203.47]) ([10.254.203.47])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Mar 2020 07:03:46 -0800
Subject: Re: [bug report] NVMe RDMA OPA: kmemleak observed with
 connect/reset_controller/disconnect
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <215235485.15264050.1583334487658.JavaMail.zimbra@redhat.com>
 <ef49292b-c39d-2f0b-99ca-2835b6afff97@grimberg.me>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <708eb993-2f8b-06b5-2084-23048c24ef4b@intel.com>
Date:   Fri, 6 Mar 2020 10:03:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ef49292b-c39d-2f0b-99ca-2835b6afff97@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/5/2020 3:57 PM, Sagi Grimberg wrote:
> CCing Linux-rdma as I don't think anyone in nvme will
> have a clue to whats going on here...
> 

We will take a look at it. Thanks for forwarding!

-Denny

