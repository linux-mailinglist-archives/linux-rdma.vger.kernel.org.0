Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D25BF5A8
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfIZPPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:15:02 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45501 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfIZPPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:15:02 -0400
Received: by mail-pg1-f172.google.com with SMTP id q7so1712475pgi.12
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 08:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y2m6Nag0q0/DfVoBcHDZTzQYJ8TIcfkqLeUBhKKTLAI=;
        b=npcF0aFclHquvv7t1i2LPsxSLcX2afpSY1aPWS6/mjBf3waEGIbePqtvpJJwdOcM+L
         V6BijVCCdBkuts7H8f4sR/59svfNPwO73eVixcbZibHkLGb6g+i3VcX1lganI89akMOC
         l90IWxtkv7qeudCSLR8iFbF360DzLxKDbc/52+iBweJ1XsLRcEzqx0J5fFIeF+7E72oG
         JlPISiVSApb2BljjbwAVP13LGoMQERTGibRtE/gxpDrroFgtB5cTCaDf3qx1VQhJByCx
         +D4NJ7RRcTRk0bHHXrWioqpxGOFVp54/Dy1ey2jOAy56zUS79DzKLlce2ukh7IZHyzcg
         S8KA==
X-Gm-Message-State: APjAAAUPb9PuDCH+jPXJTVsgYWgKk/gNEsovQdlLNUwlhD4d6SrN6xFk
        NNTBRSVOoM+gi5cpxAofAEBhacKZ
X-Google-Smtp-Source: APXvYqzasBQ8LLiFAo9Kv8aeYBNRexKTCx6Lw+SEIgGv28YiEMEk2moBTXc0329LMGpqabsLyC5/KA==
X-Received: by 2002:aa7:8697:: with SMTP id d23mr4289805pfo.34.1569510901212;
        Thu, 26 Sep 2019 08:15:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a17sm2681737pfi.178.2019.09.26.08.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:15:00 -0700 (PDT)
Subject: Re: SRP subnet timeout
To:     Karandeep Chahal <karandeepchahal@gmail.com>,
        linux-rdma@vger.kernel.org
References: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
 <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
 <dbdc27d0-93bf-947c-0c6c-41f4a7d20385@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0068b947-a405-fec3-c0e4-6be4c78c7448@acm.org>
Date:   Thu, 26 Sep 2019 08:14:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dbdc27d0-93bf-947c-0c6c-41f4a7d20385@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On 9/26/19 8:00 AM, Karandeep Chahal wrote:
> I understand that you have made "SRP CM timeout dependent on subnet 
> timeout", but my
> question is, why did you add "2" to the subnet timeout? How did you come 
> up with
> this number?
> 
> Forgive me but it is not obvious to me after reading the commit message.

Hi Karandeep,

I haven't done any kind of deep research to come up with that value. My 
goal was to preserve the CM timeout used by the SRP initiator for the 
default opensm subnet timeout value (18). There may be better choices 
for the SRP CM timeout.

Bart.

