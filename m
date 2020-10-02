Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09E7281DBF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgJBVlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 17:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBVlm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 17:41:42 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C3C0613D0
        for <linux-rdma@vger.kernel.org>; Fri,  2 Oct 2020 14:41:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x69so2681242oia.8
        for <linux-rdma@vger.kernel.org>; Fri, 02 Oct 2020 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wef99J/qT2DUOnB4bpdorE+YD79yL9Eiw35X5p8Cbz8=;
        b=iKMNH4ThADkbMTFnd397h29YBsJP4H3hAD6YRKV20vlPhVeLNfo2MxTORXEJVJwdhi
         Oe3G58p7pvdwf/h2OlkGCmF+jdbMGJdbK7UDGlw6TVRxzr9/2Ko22kurhtH+bZpeyE1M
         KB/HZRC2xDdP2+8gS6UfpoLUF8WInCYBffXybZ6mHkqr+ahrJWOzBrpGnB8lEfLJgWSZ
         fzRh/o8/+R9CtZEy6Ut0N1ftG/OZuX9WaH9d/kjoViCRAXueGLU2TDu41HsRxbDIZZPi
         VYN3H58mlxeO7Qi+A07FFb17SqcnxO8W4eGAi8hU9jGiXPTg2QB+GQmlBM0jTyqWHwY/
         4Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wef99J/qT2DUOnB4bpdorE+YD79yL9Eiw35X5p8Cbz8=;
        b=kuU9Pe3m8/IEmi+mpUnoXOwLj2/avoeUbzykjNxRialsbQsyH17qh3Yg/5wurCNihO
         Te8dVYc6o5fJpgVVijEBpxrftYbDN0eJiB0a2C9Oyap7zSaDhhJuOhKoRtZvct3dEz1R
         AwFGXqEhZoW8Z7AZdodeiTkqZwEpaBSljRe0tuuBvSRXbEghGB1gUhs6zh5t077/TAN6
         jtLjrUpqEaX4gFqpieH/M3uF57h05vvB5cymQMeFhyhEIPMQaO1OiDi7XOa/el6U5sNL
         yO+2MJk3Xht2vgpWL/QaUZX9f+Cp4c2WhXmH1uhEUFtjCRBfh7wntBWFl8UwxUdLs0Xs
         ZCfw==
X-Gm-Message-State: AOAM530C1fmnN6pjzbWiKLh7Vk0/JGty0utItAXD7Oa/lTPpWnnn1GyT
        MZym2o1Angpnwo4WaajsxG8=
X-Google-Smtp-Source: ABdhPJz6QvWV4w5yqzzONYnrzxjL4A3B3DA4Y5jpXPVj8iTh0OLUA9ry5tTdySgCScu7l6/uRn6lHg==
X-Received: by 2002:aca:388:: with SMTP id 130mr2397261oid.145.1601674901571;
        Fri, 02 Oct 2020 14:41:41 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:854e:2d13:6043:4f5a? ([2605:6000:8b03:f000:854e:2d13:6043:4f5a])
        by smtp.gmail.com with ESMTPSA id p16sm677543otl.17.2020.10.02.14.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 14:41:41 -0700 (PDT)
Subject: Re: py verbs tests
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
References: <1c6511ba-e92e-c285-e00d-f2dba04a6747@gmail.com>
Message-ID: <babfc88f-e2e7-a988-2c4f-f18f24713992@gmail.com>
Date:   Fri, 2 Oct 2020 16:41:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c6511ba-e92e-c285-e00d-f2dba04a6747@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/2/20 4:34 PM, Bob Pearson wrote:
> I am currently trying to figure out why one of the pyverbs tests is failing.
> 
> I added a check implementing C9-205 (p 419) of the IBA spec. I requires that a responder receiving a packet longer
> than the receive buffer or the PMTU shall be silently dropped. I.e. a class D error.
> 
>     C9-205: Before executing the request, the responder shall validate the
>     Packet Length field of the LRH and the PadCnt of the BTH as described
>     in 9.8.3.2.2: Responder - Length Validation.
>     The following characteristics shall be validated:
>     • The Length fields shall be checked to confirm that there is sufficient
>     space available in the receive buffer specified by the receive WQE.
>     • The packet payload length must be between zero and PMTU bytes
>     inclusive in size.
>     If a packet is detected with an invalid length, the request shall be an invalid
>     request and it shall be silently dropped by the responder as specified in
>     Section 9.9.3 Responder Side Behavior on page 435. The responder then
>     waits for a new request packet.
> 
> tests/test_cq_events.py passes PATH_MTU = 1024 in the modify QPs verb for RC and XRC but not UD.
> This should be a required parameter as part of the primary destination address but is not getting
> set for UD. The test then proceeds to send a 1024 byte payload to the destination and for UD hangs
> waiting for the completion.
> 
> I don't want to mess with these tests because I am a poor python coder. Is there some reason why it is
> OK to not set the PMTU for UD QPs?
> 
> Bob
> 

Duh. It's not connected therefore there is no path and thus no path mtu.

