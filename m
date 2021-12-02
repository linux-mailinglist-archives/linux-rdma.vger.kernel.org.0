Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC984669FE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 19:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbhLBSqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 13:46:12 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:45958 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbhLBSqM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 13:46:12 -0500
Received: by mail-pl1-f172.google.com with SMTP id b11so329550pld.12
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 10:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=luyMF39Kww9LIOe9SjFaeI93tERTdaLmVdyPo4TNpX8=;
        b=6CylHSk3wNGoAu0irP7ZHXnhQkeRHVj4xH9kXSAsR/DEYFiI7Rl3Kz4Z8grwhVnOeq
         WPJrXWuAaP7JU86wkphPNZM/FrW8N3rD6lBXoOwyUJy9katGLknoiFI/THgQuAbs8PYo
         8j8AaJA/3EmPg2gs6AIWnCN8pW2hnYDxPzs1Jbm/TNeh4VVd8kbTThjYL/QKcYNAYlbc
         0ie1i3uiOq7ANtxwV8/MpkBYJJjr2Dy5lR57D2aDfSptJm8aeuCIdNo7UGXO2OZ/+emI
         wHg4VESnZMEsOz6w7i5nLc3bigLmpd28/ValvSJEmpaXNoQUzv6/O4Yn7q+iPPsjjfZ/
         kLJA==
X-Gm-Message-State: AOAM531JqInbEaXXiYonj6ZDVDNTAab1Cko6SUvBnwXkcApbG7vhJN03
        ikeQyTgpBnb0bIxpJ9eKfsZ3acgw3A0=
X-Google-Smtp-Source: ABdhPJzFcz8L7e78Oq8zWLgAq7kK5wqOZa3FV96Vm5YT5+GErwn09kuH7DVwJF3Wqk6ShmI+iN8OUQ==
X-Received: by 2002:a17:902:d505:b0:142:175d:1d4 with SMTP id b5-20020a170902d50500b00142175d01d4mr17146688plg.50.1638470568973;
        Thu, 02 Dec 2021 10:42:48 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:fac5:b2eb:ef0d:f30b])
        by smtp.gmail.com with ESMTPSA id h8sm321179pgj.26.2021.12.02.10.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 10:42:48 -0800 (PST)
Subject: Re: [bug report] blktests srp/011 hang at "ib_srpt
 srpt_disconnect_ch_sync:still waiting ..."
To:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8d41da04-717e-8116-c091-83393990dd84@acm.org>
Date:   Thu, 2 Dec 2021 10:42:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/1/21 12:55 AM, Yi Zhang wrote:
> [root@gigabyte-r120-11 blktests]# use_siw=1 ./check srp/011 -------------> hang

Hi Yi,

Does this only occur with the siw driver or also with the rdma_rxe driver?

If this hang occurs with both drivers, how about bisecting this issue? I
have not yet run into this issue with the rdma_rxe driver and Linus' master
branch.

Thanks,

Bart.
