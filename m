Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9A97AFA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfHUNhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:37:00 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:47304
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfHUNhA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:37:00 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id 0QnKiQDflvpJA0QnLiPeEj; Wed, 21 Aug 2019 06:36:59 -0700
Subject: Re: CX314A WCE error: WR_FLUSH_ERR
To:     "Liu, Changcheng" <changcheng.liu@intel.com>,
        linux-rdma@vger.kernel.org
References: <20190821120912.GA1672@jerryopenix>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <6aed3f75-2445-eb6f-0bd8-7c79ea4a0967@talpey.com>
Date:   Wed, 21 Aug 2019 09:36:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821120912.GA1672@jerryopenix>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLRcy5m9fMRcMtB4LHZjgRrc7pFO4EFbqo4KflNwfjt4M0UWZA+ejCbIRoZIngk7lGSD6WPfeQyDCWhPQTsvpcR7xJVEEmrWbwvGfcMPgkua5PrPQ4KZ
 PoHu1LR3Z1dJKNSi0hYfDyE0WmUdNbfuNVl+qe8+OwbLamK7dqHdnMZqmibILX3C8WghuyprLLPPf51ssx8wXjHhrE+fRGjJvcA=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/2019 8:09 AM, Liu, Changcheng wrote:
> Hi all,
>     In one system, it always frequently hit "IBV_WC_WR_FLUSH_ERR" in the WCE(work completion element) polled from completion queue bound with RQ(Receive Queue).
>     Does anyone has some idea to debug "IBV_WC_WR_FLUSH_ERR" problem?
> 
>     With CX314A/40Gb NIC, I hit this error when using RC transport type with only Send Operation(IBV_WR_SEND) WR(work request) on SQ(Send Queue).
>     Every WR only has one SGE(scatter/gather element) and all the SGE on RQ has the same size. The SGE size in SQ WR is not greater than the SGE size in RQ WR.
> 
>    There’s one explanation about IBV_WC_WR_FLUSH_ERR on page 114 in the "RDMA Aware Networks Programming User Manual" http://www.mellanox.com/related-docs/prod_software/RDMA_Aware_Programming_user_manual.pdf
>    But I still didn't understand it well. How to trigger this error with a short demo program?
>    "
>      IBV_WC_WR_FLUSH_ERR
>      This event is generated when an invalid remote error is thrown when the responder detects an
>      invalid request. It may be that the operation is not supported by the request queue or there is
>      insufficient buffer space to receive the request.
>    "

The most common reason for a flushed work request is loss of
the connection to the remote peer. This can be caused by any
number of conditions.

The second-most common is a programming error in the upper
layer protocol. A shortage of posted receives on either peer,
a protection error on some buffer, etc.

If you're looking to actually trigger this error for testing,
well, try one of the above. If you're trying to figure out
why it's happening, that can take some digging, but not in
the RDMA stack, typically.

Tom.

