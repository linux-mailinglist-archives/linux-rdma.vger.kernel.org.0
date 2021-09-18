Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8641E41031A
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Sep 2021 04:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhIRC5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Sep 2021 22:57:47 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46668 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhIRC5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Sep 2021 22:57:46 -0400
Received: by mail-pf1-f172.google.com with SMTP id 203so3043112pfy.13
        for <linux-rdma@vger.kernel.org>; Fri, 17 Sep 2021 19:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/0svKMYF/U5sj468fyuuRmU3EekandrEswYvt6SOMmo=;
        b=QvBUu9mjeoF1PBoLkTJaqDMESxYOsM9vguZMJlsxWd46pqo+WdBlOntpEQdz/Qtb5x
         8hJr9icVm3y8AjnIthqJXJNcEcjNUE+gDrQmaikkZINTsrCPX9T7J8Blp/bCTLhOWM1g
         Q1FDbAQeEgEnXW7P2qUhwTqiLKO7d9c180/wcGJV9wmQXN/bPBU6YX+0xMR3g+2QE/wZ
         3AImtAGXvetHagvqnL65IJ60fHBCDuuVrrjjoz1hPVb4g72HNk0naheS9tLBoP6Mm8pG
         kPwJVCyB8bFa1Rod5oMj3jnthNvF2zrZf885LTjFRHVOvce71KYrSeuDXe+P4o4Ub3NQ
         GHjg==
X-Gm-Message-State: AOAM530ZIqJeV3ryrjVBQc4r9ZdxYBogJ11WHMx7ki4oDAzVWv6jOMvE
        7OzNjLsGg91JsmDf4wrrQEQ=
X-Google-Smtp-Source: ABdhPJxfLuzJIc6MTLzEjzkzyw1nwDtrrhiqYl5HlAgyRzGaH+puJbBdD13W9fdv2M4mNTmia0XfHw==
X-Received: by 2002:a63:7211:: with SMTP id n17mr12667089pgc.456.1631933783310;
        Fri, 17 Sep 2021 19:56:23 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:eb4a:447e:487f:caa3? ([2601:647:4000:d7:eb4a:447e:487f:caa3])
        by smtp.gmail.com with ESMTPSA id p4sm7475984pgc.15.2021.09.17.19.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 19:56:22 -0700 (PDT)
Message-ID: <79755291-a36f-535c-03b8-73178f80ca5e@acm.org>
Date:   Fri, 17 Sep 2021 19:56:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: Issus with blktest/srp on 5.15-rc1 and rdma_rxe
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Yi Zhang <yi.zhang@redhat.com>
Cc:     Robert Pearson <rpearsonhpe@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <CAHj4cs9Rzte5zbgy7o158m7JA8dbSEpxy5oR-+K0NQCK1gxG=Q@mail.gmail.com>
 <OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
 <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>
 <OFC7347FF0.D24DF679-ON00258753.002DFE5F-00258753.002E19D7@ibm.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <OFC7347FF0.D24DF679-ON00258753.002DFE5F-00258753.002E19D7@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/17/21 01:23, Bernard Metzler wrote:
> -----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----
>> Just try use_siw=1 ./check -q srp/005
> 
> srp/015 seem to be dedicated to siw testing. It selects siw if available.
> I think this is how Bart found it.
> Unfortunately, for some reason I am not aware of, testing defaults to
> rxe only for the other tests. Maybe at least the helper should
> talk about this hidden option.

Originally only test srp/015 selected siw. Yi Zhang added support for
running all SRP tests with the siw driver. See also blktests commit
d23c3aa0c1c0 ("common/multipath-over-rdma: allow to set use_siw"). How
about submitting a documentation patch to the blktests project?

Thanks,

Bart.
