Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862A02FC52
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE3N1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:27:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:51424 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfE3N1R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 09:27:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 06:27:16 -0700
X-ExtLoop1: 1
Received: from unknown (HELO [10.228.129.69]) ([10.228.129.69])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2019 06:27:15 -0700
Subject: Re: [PATCH rdma-next v1 2/3] RDMA: Clean destroy CQ in drivers do not
 return errors
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-3-leon@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <7b775df7-2cc9-08bf-b953-84d2356dcc04@intel.com>
Date:   Thu, 30 May 2019 09:27:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528113729.13314-3-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/2019 7:37 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Like all other destroy commands, .destroy_cq() call is not supposed
> to fail. In all flows, the attempt to return earlier caused to memory
> leaks.
> 
> This patch converts .destroy_cq() to do not return any errors.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

For rdmavt stuff:

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
