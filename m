Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF6BF563
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfIZPA0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:00:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38819 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIZPA0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:00:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so3233688qta.5
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FP2rlS5XRzvH0mQtDW8kPoAtt3aL00TT5rmtwNev6ro=;
        b=jAOwyA9OpMMrx/zJEtYFoLz0PL5+5ScjuicCO08iibnwPnnuLX6+WG89SkJpjhh8Yt
         BKnekS/xo6ymU1B8TSJrU79xxDCNAO7jJQj8ICTEMX+XyFDNxochwVvrtzfahzlPog6Y
         WxyUMop1tDRZUx1htrK370l+C6CGrK5EmEHVkzRltmP4k/fmNCfzpwP4eq6//uaQWvjR
         TuRFGFxfiqCJGmI7dyF6CH8WgvJ/N0JDZgrRkabkfXc6bGc94LnIXtLzwbIdYAGMLmU8
         fCTbwFQXggW8SDRcKVizNFLXyQ91i/MCiE20fjZxJkyOM54LrS8gZVSi0v3kjfyC6DC2
         zIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FP2rlS5XRzvH0mQtDW8kPoAtt3aL00TT5rmtwNev6ro=;
        b=QGWqroGuyEMsEA+BJdZuK6Kb6zlFrdcLsFOm0AVoN1Uf0/NTj1iT4qXJBpZEFTahI0
         KOvDRfysRUW0HPQzDiSkIIz1nyAM0n8QIHp6rSzNFoYJDY4C8de4KodNXf1c3etIFgj7
         iI8lcwbnArxb6FzDvd8j45pqgLLyLcLQM0Qfzab9Iy17AWt3ofbT0en1avPX3TTFfICu
         K/bArlcGFfdpoSifcO2iORL3EUi5qS1fD2InslCpSxzE0bF3kyxHfq3tL2ubpAUbAUTX
         9au00f+ARegxQy//muIOlHw8F+zr4neC3aAROy+mpPJI1woT/O8kK1PZj3tgswfHLtvp
         +COw==
X-Gm-Message-State: APjAAAWiUKWr0oMRvmZsprksa8f/mvxAdpczVFYR/ws5gCSCk+P/M2o/
        BHo8kUFih1sQndceMZH1sY0=
X-Google-Smtp-Source: APXvYqxEssznmJcniX2pv2HgI0xBlhmFx204Mxjv54I603LoTHpexoghCYo7G74MO0Uq6SpFOY9bhQ==
X-Received: by 2002:ac8:340d:: with SMTP id u13mr4287419qtb.103.1569510025453;
        Thu, 26 Sep 2019 08:00:25 -0700 (PDT)
Received: from [10.48.108.64] (DATADIRECT.bear1.Baltimore1.Level3.net. [4.34.0.142])
        by smtp.gmail.com with ESMTPSA id q47sm1640929qtq.95.2019.09.26.08.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:00:24 -0700 (PDT)
Subject: Re: SRP subnet timeout
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org
Cc:     bart.vanassche@wdc.com
References: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
 <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
From:   Karandeep Chahal <karandeepchahal@gmail.com>
Message-ID: <dbdc27d0-93bf-947c-0c6c-41f4a7d20385@gmail.com>
Date:   Thu, 26 Sep 2019 11:00:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bart,

I understand that you have made "SRP CM timeout dependent on subnet 
timeout", but my
question is, why did you add "2" to the subnet timeout? How did you come 
up with
this number?

Forgive me but it is not obvious to me after reading the commit message.

Thanks
-Karan

On 9/26/19 10:54 AM, Bart Van Assche wrote:
> On 9/26/19 7:10 AM, Karandeep Chahal wrote:
>> I am wondering why SRP REQ CM timeout is "subnet_timeout + 2". What 
>> was the
>> reason behind adding 2 to the subnet timeout? I think it was added by 
>> Bart
>> in commit 4c532d6ce14bb3fb4e1cb2d29fafdd7d6bded51c, but the commit 
>> message
>> does not explain why the 2 is necessary. Would anyone happen to know?
>>
>> My understanding is that adding 2 causes the CM timeout value to 
>> become 4 times
>> the subnet_timeout value. Hence, even if you have a reasonable 
>> subnet_timeout
>> the CM REQ timeout becomes too high.
>
> Hi Karan,
>
> I think the description of that commit explains why that change has 
> been made:
>
>     IB/srp: Make CM timeout dependent on subnet timeout
>
>     For small networks it is safe to reduce the subnet timeout from
>     its default value (18 for opensm) to 16. Make the SRP CM timeout
>     dependent on the subnet timeout such that decreasing the subnet
>     timeout also causes SRP failover and failback to occur faster.
>
> Bart.

