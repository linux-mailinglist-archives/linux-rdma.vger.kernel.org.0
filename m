Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6F3EBDFB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhHMVk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 17:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHMVk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Aug 2021 17:40:26 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E64C061756
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 14:39:59 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so6238161otv.11
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fqrVM8T4SNwCXH1L7KLAN8zVzHQDazRuzf3yqTvQb2k=;
        b=N4Wb1tJIMu5d38i9Q0nr9McnaMcpUdQTI+DTil5KOj8dY0mGmMRQtuXBc3hroVXuoL
         0gElKdjsBb4bvav5XnI5bmO4tEGOR/MbOtRKEV9XaQ9AW1cGYXyKKSiByozVmX5M8r3u
         goa7VajvO4Kvd+iWqVchu1IqjO1oYxXtKfjOGjrsxOqN+psxNCDbEkqV+JIy9HoxsYlh
         9XX5q3/j9rc5xxRLVwMUgyQhdeEHmbMHQRHtzbFBcgAuuEtIX1RW1NwnmgBt7Yudyt4W
         6GT+3Fk+cJNLbEj3ewYm98VCMAjScD3KFS+ZIy2KS4LePu3nWvV2GzQp/tm/iq/byjBf
         CxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fqrVM8T4SNwCXH1L7KLAN8zVzHQDazRuzf3yqTvQb2k=;
        b=IR5ifG0rS7o2LTVsY7Ul86eB0e5OlDzVf3p2SxxkX0cAnq3Iv/G7rZlSej2/9FF4vj
         TIiXVi6yebnupLUhFteC4WlUFas+b6kM3TOQVEgIqvuAVbT9+Vh/Knc348PCk6XSYTw9
         grsk5bl2YymMm0bzeoCztw1XZWgmIYUoHj4Av3ZKkliCMECdEiub6qUGP6qBHWKh64oo
         bH6y8gqpBCyWoBojeEY6bXh2yLSi+L1yvZQVIUX0ZnLJUIUXRuQqiJqIWGRJGGGCDjEY
         9x3+vHWjcl6Iyuhf+4CyOUDhq32DwmEKPg/A0HnI/bW59gnIZS9nhyWMMQy7tgF6Ueax
         I8Yg==
X-Gm-Message-State: AOAM533Gi+jITmYCRHUemoBE+E13Du9q43+uO00OEDAfN8yIsNsK9dfj
        Ucqx+AVNRAwcIzTovjoE1nIYx+9DI0g=
X-Google-Smtp-Source: ABdhPJynlD3WXeHxSPQSR6/jLZIYaDwdSsunRlr/lLSddBLNyNV9M2XEgSRtbPwTZYCFCyk9GDwsaA==
X-Received: by 2002:a05:6830:2490:: with SMTP id u16mr3714409ots.356.1628890798905;
        Fri, 13 Aug 2021 14:39:58 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5f86:1d06:aef7:df6b? (2603-8081-140c-1a00-5f86-1d06-aef7-df6b.res6.spectrum.com. [2603:8081:140c:1a00:5f86:1d06:aef7:df6b])
        by smtp.gmail.com with ESMTPSA id b5sm416378oif.44.2021.08.13.14.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 14:39:58 -0700 (PDT)
Subject: Re: [PATCH 5/5] Providers/rxe: Support XRC traffic
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
 <20210730152157.67592-6-rpearsonhpe@gmail.com> <YQetIxKBrtpBvL5Y@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <32738f39-840b-eace-4b4c-900b71fd6d05@gmail.com>
Date:   Fri, 13 Aug 2021 16:39:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQetIxKBrtpBvL5Y@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/2/21 3:30 AM, Leon Romanovsky wrote:
> On Fri, Jul 30, 2021 at 10:21:58AM -0500, Bob Pearson wrote:
>> Extended create_qp and create_qp_ex verbs to support XRC QP types.
>> Extended WRs to support XRC operations.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  providers/rxe/rxe.c | 132 ++++++++++++++++++++++++++++++++------------
>>  1 file changed, 96 insertions(+), 36 deletions(-)
> 
> <...>
> 
>> +static void wr_set_xrc_srqn(struct ibv_qp_ex *ibqp, uint32_t remote_srqn)
>> +{
>> +	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
>> +	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
>> +						   qp->cur_index - 1);
>> +
>> +	if (qp->err)
>> +		return;
> 
> Why is that?
> 
>> +
>> +	wqe->wr.wr.xrc.srq_num = remote_srqn;
>> +}
>> +

qp->err is used to detect overrun in the send WQ. Each of the 'builders' calls check_qp_queue_full()
and sets qp->err if there isn't any more room in the send queue. Since the routines are of type void
there is no way to tell the caller that something bad has happened. Once the builder fails the
'setters' have to fail as well because there is no place to write the WQE parameters. If this happens
the user space caller will will see the operations succeed up to the point that it ran out of room and
then stop. This is sort of a half solution to the problem. The alternative is to say that the user can
never make this mistake and just keep building WQEs wrapping around the queue.

Bob

