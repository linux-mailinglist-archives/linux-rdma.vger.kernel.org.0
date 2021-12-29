Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A1481374
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 14:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhL2NTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Dec 2021 08:19:53 -0500
Received: from btbn.de ([136.243.74.85]:48298 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhL2NTw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Dec 2021 08:19:52 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2021 08:19:52 EST
Received: from [authenticated] by btbn.de (Postfix) with ESMTPSA id 8D84822B3C6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Dec 2021 14:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1640783436;
        bh=b5gL1YvHRpOqelY8ojIjvzOppOqvgD++paoub8KAXsc=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=kFiCA+e6b6WdzDosE53lm/mnnS+X89HaEHoCJd59heQdWMDhQLHNlr/ktesqs1zcV
         MvcFjLJ8O8DyOShlRGrU4/Yx2/CUMvQyu4ciQGMawtAprD7yuw10S66nNoJdl7U6+c
         wkuRS7iGfPRM3aL4R9Od0tJEd8UQP9yfNKn3/BnQ/Hx2a7GJuNnMzasN81ltBmBZjP
         IcESx/y3HECrjBEAzJKL2TBm00leaqlfstG8eOxshaWP34GM7eQ9KMxQGyWdrLgrZO
         KaMuFpNA8vBvl7BrauOoAhjyNwOapIb6shUWbaz3VJpt8EuFuGXy2f3/XOIlKsgCy6
         aBdYPeHkEAxOw==
Message-ID: <1b133ec9-b47f-10e1-7e9f-f3393c1d7c44@rothenpieler.org>
Date:   Wed, 29 Dec 2021 14:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated
 memory in dereg MR flow"
Content-Language: en-US
To:     linux-rdma <linux-rdma@vger.kernel.org>
References: <20211222101312.1358616-1-maorg@nvidia.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
In-Reply-To: <20211222101312.1358616-1-maorg@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030700000909010107040109"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030700000909010107040109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.12.2021 11:13, Maor Gottlieb wrote:
> This patch is not the full fix and still causes to call traces
> during mlx5_ib_dereg_mr().
> 
> This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.

What is the status of this in the latest stable Kernel?
I see that f0ae4afe3d35e67db042c58a52909e06262b740f was backported into 
5.15, but since then, no fix or revert made it into 5.15.

I wanted to upgrade our cluster to 5.15 soon, but I'm a bit concerned 
about reports of issues surrounding this patch.

--------------ms030700000909010107040109
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA7eaHlqHBpLbtwkJV9z8PDyJgXxPgpkOI
hkmReRwbLxpQD9xGAe72ujqGzFFh78QPgAhxKVqtGHzYeq0VJVCzhnCKRBbVX+JwIhL3ULYh
UAZrViUp952qDB6qTL5sGeJS9F69VPSR5k6pFNw7mHDTTt0voWFg2aVkG3khomzVXoieJGOi
Q4dH76paCtQbLkt59joAKz2BnwGLQ4wr09nfumJt5AKx2YxHK2XgSPslVZ4z8G00gimsfA7U
tjT/wiekY6Z0b7ksLrEcvODncHQe9VSrNRA149SE3AlkWaZM/joVei/GYfj9K5jkiReinR4m
qM353FEceLOeBhSTURpMdQ5wsXLi9DSTGBuNv4aw2Dozb/qBlkhGTvwk92mi0jAecE22Sn3A
9UfrU2p1w/uRs+TIteQ0xO0B/J2mY2caqocsS9SsriIGlQ8b0LT0o6Ob07KGtPa5/lIvMmx5
72Dv2v+vDiECByxm1Hdgjp8JtE4mdyYP6GBscJyT71NZw1zXHnFkyCbxReag9qaSR9x4CVVX
j1BDmNROCqd5NAfIXUXYTFeZ/jukQigkxXGWhEhfLBC4Ha6pwizz9fq1+wwPKcWaF9P/SZOu
BDrG30MiyCZa66G9mEtF5ZLuh4rGfKqxy4Z5Mxecuzt+MZmrSKfKGeXOeED/iuX5Z02M1o7i
MS8CAwEAAaOCAfQwggHwMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUUtiIOsifeGbt
ifN7OHCUyQICNtAwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA1
LmFjdGFsaXMuaXQvVkEvQVVUSC1ST09UMEUGA1UdIAQ+MDwwOgYEVR0gADAyMDAGCCsGAQUF
BwIBFiRodHRwczovL3d3dy5hY3RhbGlzLml0L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMIHjBgNVHR8EgdswgdgwgZaggZOggZCGgY1sZGFwOi8vbGRh
cDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVudGljYXRpb24lMjBSb290JTIw
Q0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0
L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwHQYDVR0OBBYEFL6XqaqEv4C/EFN9
CTL54S4yG893MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQsFAAOCAgEAJpvnG1kNdLMS
A+nnVfeEgIXNQsM7YRxXx6bmEt9IIrFlH1qYKeNw4NV8xtop91Rle168wghmYeCTP10FqfuK
MZsleNkI8/b3PBkZLIKOl9p2Dmz2Gc0I3WvcMbAgd/IuBtx998PJX/bBb5dMZuGV2drNmxfz
3ar6ytGYLxedfjKCD55Yv8CQcN6e9sW5OUm9TJ3kjt7Wdvd1hcw5s+7bhlND38rWFJBuzump
5xqm1NSOggOkFSlKnhSz6HUjgwBaid6Ypig9L1/TLrkmtEIpx+wpIj7WTA9JqcMMyLJ0rN6j
jpetLSGUDk3NCOpQntSy4a8+0O+SepzS/Tec1cGdSN6Ni2/A7ewQNd1Rbmb2SM2qVBlfN0e6
ZklWo9QYpNZyf0d/d3upsKabE9eNCg1S4eDnp8sJqdlaQQ7hI/UYCAgDtLIm7/J9+/S2zuwE
WtJMPcvaYIBczdjwF9uW+8NJ/Zu/JKb98971uua7OsJexPFRBzX7/PnJ2/NXcTdwudShJc/p
d9c3IRU7qw+RxRKchIczv3zEuQJMHkSSM8KM8TbOzi/0v0lU6SSyS9bpGdZZxx19Hd8Qs0cv
+R6nyt7ohttizwefkYzQ6GzwIwM9gSjH5Bf/r9Kc5/JqqpKKUGicxAGy2zKYEGB0Qo761Mcc
IyclBW9mfuNFDbTBeDEyu80xggPzMIID7wIBATCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFs
aXMgUy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MwIQCP8se1eXTyBvFrjHrZ83LDANBglghkgBZQMEAgEFAKCCAi0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMjI5MTMxMDMxWjAvBgkqhkiG9w0BCQQx
IgQgBZdlPGj+3iTAtJqSndYG0snflhmmLtw9G4MBdnVxJuIwbAYJKoZIhvcNAQkPMV8wXTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpwYJKwYBBAGCNxAEMYGZ
MIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUg
U2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAI/yx7V5dPIG8WuMetnzcsMIGpBgsqhkiG
9w0BCRACCzGBmaCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNV
BAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQD
DCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMwIQCP8se1eXTyBvFrjHrZ83
LDANBgkqhkiG9w0BAQEFAASCAQAHdJoFlTaRZKL/Ebg+/hp+wdLIfB4N+SXGCH2myqxDzynz
BV9kQsQmWyrzOqiWycOuw76pjpvOmH0Y9Eyc3bUYclDozqZd176Eem/hBbUFpzdGkqJO4Lif
o/JHShDdJ5Bk7tjuvu5JnXwNKO2U2108SyQ4LdLofQCq8Jb6lDVnlHkKcLrCqqzDnYq8IItp
ZaN5acEhNywusgW951IgLAi0ehTnE0MmKmx4AuXRI0KNLDSHu20mV6GZd/SAmAdKgQAq0QZn
b5ao/wdf0OGDNyQDa6nWQHzNQpO00VtCb9ddlNKqiOM+FgE2rlcfdBXVLEtLKeuBPgJBXv9+
e8tEL/6+AAAAAAAA
--------------ms030700000909010107040109--
