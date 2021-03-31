Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04BF35063D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhCaSX4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 14:23:56 -0400
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:33813
        "EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234442AbhCaSX1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 14:23:27 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id RfUxlGDeD5NJSRfUylk6Yh; Wed, 31 Mar 2021 11:23:25 -0700
X-CMAE-Analysis: v=2.4 cv=bPLTnNyZ c=1 sm=1 tr=0 ts=6064be1d
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=7HJHzDMhKbaViaExzT8A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: QP reset question
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <dec67c77-5870-12a9-3308-dd24ffbcfa8b@gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <6ac535d3-ce08-7e00-721e-63529d81c85d@talpey.com>
Date:   Wed, 31 Mar 2021 14:23:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <dec67c77-5870-12a9-3308-dd24ffbcfa8b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGts86OvDDC/z/gikQcceOd/VGwOWjjrE5RNKFbW5tiFhI5WjvN6Et4DHNrLlD0HlLotiCS2+G2z7mGYMvnEM2SnBr+zhNLpF5OShgDY+QUmjfHPRV7I
 0dkZDrkNAPWL7YmNgfeptKCqrUgbdE3g4W4kNFvokbuiSqmK5TIrBVgR8TdG2vDRXpu9RVtYKJViNPFAYkraTUh+txbaSv90NpDcqXOfvzKxrlPdgAnsID6i
 xCskspDRtp0egH02WhmR1g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/2021 5:01 PM, Bob Pearson wrote:
> Jason,
> 
> Somewhere in Dotan's blog I saw him say that if you put a QP in the reset state that it
> - clears the SQ and RQ (if not SRQ) *AND*
> - also clears the completion queues

I don't think that second bullet is correct, as you point out the
CQ may hold other entries, not from this QP.

The volume 1 spec does say this around QP destroy in section 10.2.4.4:

>> It is good programming practice to modify the QP into the Error
>> state and retrieve the relevant CQEs prior to destroying the QP.
>> Destroying a QP does not guarantee that CQEs of that QP are
>> deallocated from the CQ upon destruction. Even if the CQEs are
>> already on the CQ, it might not be possible to retrieve them. It is
>> good programming practice not to make any assumption on the number
>> of CQEs in the CQ when destroying a QP. In order to avoid CQ
>> overflow, it is recommended that all CQEs of the de-stroyed QP are
>> retrieved from the CQ associated with it before resizing the CQ,
>> attaching a new QP to the CQ or reopening the QP, if the CQ
>> ca-pacity is limited.

There's additional supporting text in 10.3.1 around this. The
QP is always transitioned to Error, then CQEs drained, then QP
to Reset.
> Rxe does nothing special about moving a QP to reset. A few of the Python negative test cases intentionally
> force the QP into the error state and then the reset state before modifying back to RTS. They fail if they
> do more work and expect it to succeed but get flush errors instead left over from the earlier failed test.
> 
> I have not found anything in the IBA that mentions this but it could be there. This will be a little tricky
> if the CQ is shared between more than one QP. But easier for me to fix than changing the Python code.

I think this sounds like a test issue.

Tom.

> Do you know how this is supposed to work?
> 
> bob
> 
