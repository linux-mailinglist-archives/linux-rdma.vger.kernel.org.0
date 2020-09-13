Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A70267FD2
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Sep 2020 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMOvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Sep 2020 10:51:10 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:46185 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgIMOvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Sep 2020 10:51:08 -0400
Received: by mail-pf1-f182.google.com with SMTP id b124so10391781pfg.13;
        Sun, 13 Sep 2020 07:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yD/3+HTWCSur4HDtLCV8fvDnq1bK1MEzAie36X2p7qg=;
        b=mL2BSZMzosRveRie0tAdTFuZIZ8wh3saI75U2Ou8dFDSIMujQHDTZPbs27Ir0fU1u3
         kE8AgzyKnGPZLqaA0AzzNYlAhtuttpXZ5ruXDibwil6zapjIyLwvhp9Yj2iZ4jiSacD8
         dsvIpCcAVEg36hChZ7YwnWo3Ffuz/wxW9teMqtxF+gsty7gt4lL0cvcDtY0dbAQcznvg
         Aq9RFp381v2v6YwJ7asiCnWrPo7FGva3A7xY70iLpxZDfiXnKBzxgrJ4wV16krEvxaCb
         Xjldz2oWXK3yGuNMQ7KpCNoQ/Zz118Y/0Xh8rFshGWcaQiRPBMgpvqFaRDD8zD5rcfMD
         Xn/g==
X-Gm-Message-State: AOAM530qWFUvS6WAOXH7uaABlLDrzlUdkwzjeMw27uPfUYY/4tvAFRht
        BKEyrDWOt2g7gWRwvKIgF1g+X9kQ8Rc=
X-Google-Smtp-Source: ABdhPJy1eNyzHKHlattYdLX9dskcckIRLaBPkL1ooB1TJMKcMnieWKOESPVJ/KDYhPcfO0VGWlO4Nw==
X-Received: by 2002:a63:2484:: with SMTP id k126mr4053548pgk.428.1600008666964;
        Sun, 13 Sep 2020 07:51:06 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id f28sm7673041pfq.191.2020.09.13.07.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:51:06 -0700 (PDT)
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org>
 <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
 <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <65ef9d97-fe45-923c-07ee-d53b975c2e0d@acm.org>
Date:   Sun, 13 Sep 2020 07:51:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/9/20 4:42 AM, Danil Kipnis wrote:
> I have two general understanding questions:
> - What is the conceptual difference between DRBD and an md-raid1 with
> one local leg and one remote (imported over srp/nvmeof/rnbd)?

Conceptually the difference is probably not that big. But the DRBD activity
log makes a huge difference when recovering from a network disconnect or
ungraceful shutdown.

> - Is this possible to setup an md-raid1 on a client sitting on top of
> two remote DRBD devices, which are configured in "active-active" mode?

Are you perhaps referring to a single DRBD cluster? I'm not sure but I think
that would make DRBD complain about concurrent writes.

Thanks,

Bart.
