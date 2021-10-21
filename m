Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B384367D0
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhJUQda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 12:33:30 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:35746 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQda (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Oct 2021 12:33:30 -0400
Received: by mail-pj1-f53.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso3577815pjd.0;
        Thu, 21 Oct 2021 09:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7q6vzNxfbvYKvr+skK0udmjoYoQnE4oH6D4ZVnH1FZ4=;
        b=TWW9vURnCOwhlWzba1aofI6NQq6KAU+i3bp576Ywcm4yX090DORTTdEn0Qb0rnzvFC
         eUtUlTypufeMvK5XvUP8Q/vBuj/WBkG/ea2mXqh+sYkSdzjO/62iKfMbwxFTgUeBr2jn
         u5VEAyN1PW7LcWsuqvGA4MdhiK3K1GLYTjcG+0IjAyBT1P1ZH2z7GoTpd6VubyR+E5zK
         DQXDmrOBvUpTVzB9QiqAX7+VwLISBPzCcSM7dxyZkZdP1QsE2CZE32JXvz7S55MeYjB1
         ooYu5Fwh080O7I3iALgaWmNOykgeFgsRiClHtlniy6rZukVIwDPvB+271Qfust/zx5hE
         fluQ==
X-Gm-Message-State: AOAM532DTaPcN4P2St/D+3l1qTYgE9tbykVk43tEw2TA7ApqYyQZHcHN
        d3j5Hc6huQonKP74iC7raWs3hUfTFQQ=
X-Google-Smtp-Source: ABdhPJzAsVfKsg0f6FiCdPf1f4WeSRQiymq+aFkY/xYpHKJYMpz+xbtEmtli9yVVwHBYBRTQbFaAMg==
X-Received: by 2002:a17:90b:2382:: with SMTP id mr2mr7961105pjb.186.1634833873331;
        Thu, 21 Oct 2021 09:31:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:452c:8e0d:d8a1:4d6])
        by smtp.gmail.com with ESMTPSA id me12sm11035926pjb.27.2021.10.21.09.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 09:31:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] kthread: Add the helper macro kthread_run_on_cpu()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
References: <20211021122758.3092-1-caihuoqing@baidu.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <52540892-ced9-5d7a-5046-917526c84381@acm.org>
Date:   Thu, 21 Oct 2021 09:31:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021122758.3092-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/21 5:27 AM, Cai Huoqing wrote:
> the helper macro kthread_run_on_cpu() inculdes

Consider using a spelling checker (inculdes -> includes).


Thanks,

Bart.
